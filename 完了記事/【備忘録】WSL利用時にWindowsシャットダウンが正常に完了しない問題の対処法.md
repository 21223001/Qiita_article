## In a nutshell  
WSL（Windows Subsystem for Linux）を導入後、Windowsのシャットダウン処理が完全に終了せず、USB給電が継続するなどの問題が発生。`WSL`と`仮想マシンプラットフォーム`の無効化によって問題が解消。

---

## はじめに  
WSLを活用してUbuntuを導入した環境において、**Windowsシャットダウン後もUSB機器への給電が止まらない**などの挙動が見られた。この問題は、**WSLのシステム連携がWindowsのシャットダウン処理に干渉**していることが原因と考えられる。

---

## 発生状況の詳細  
- `wsl --list --verbose`を PowerShell 7で実行すると「ディストリビューションは存在しない」と表示 → WSL環境は削除済み。
- それにも関わらず、**シャットダウン後もUSBが給電されたまま**。
- **PCのファンも回り続ける**ため、完全に電源が落ちていない状態。
- `高速スタートアップ` や `Windows Update` の影響ではないことも確認済み。

---

## 原因と推察  
- WSLの機能（`Microsoft-Windows-Subsystem-Linux`）および `仮想マシンプラットフォーム`（`VirtualMachinePlatform`）が**有効な状態のまま残っており**、シャットダウン時の電源管理に干渉していた可能性がある。

---

## 対処方法  
以下のPowerShell 7コマンドを管理者として実行することで、問題が解消された：

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux"
Disable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform"
```

これにより、WSLおよび仮想マシン関連機能が無効化され、**シャットダウンが正常に完了し、USB給電も停止するようになった**。

---

## 今後の対応について  
- 再度WSLを使用する場合は、以下のように再有効化する必要がある：

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux"
Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform"
```

- WSL利用後に同様の現象が発生した場合は、**機能の有効状態を確認し、不要であれば無効化**することを推奨。

---

## 備考  
- この症状は、特定のPC環境やBIOS設定によって再現性が異なる可能性がある。
- WSL2の仮想環境が**シャットダウン後もレジュームを意識した状態**でメモリに残っていることが関連しているかもしれない。



## 追記，原因と対策

この問題（WSL/仮想マシンプラットフォームがシャットダウン処理に干渉し、USB給電やファンが止まらないなど電源が完全に落ちない）は，海外のコミュニティでもいくつか報告があるよう．



* **GitHub Issues (microsoft/WSL)**

  * [WSL2 causing power drain after shutdown](https://github.com/microsoft/WSL/issues/4699)
  * 複数のユーザーが「WSL2が有効だとシャットダウンが完了しない」「USBポートが通電し続ける」「ファンが止まらない」など報告。
  * 特に「Virtual Machine Platform」が有効のままだと、WSLがバックグラウンドで仮想マシンインフラを維持する挙動があると指摘。


* **Microsoft Q\&A**

  * `Windows Subsystem for Linux 2 interferes with power management` というトピックで、WSLが電源管理を引き継いでしまう現象が相談されている。

* **Docker Community Forums**

  * Docker Desktopをアンインストールしても`VirtualMachinePlatform`が残る、再起動やシャットダウンが不安定になる事例が散見される。

### 2️⃣ Reddit / SuperUser

* `r/Windows10` や `r/docker` で、

  * **「After installing Docker Desktop with WSL2 backend, my PC never fully shuts down. Fans spinning, USB power stays on」**
  * 対処として `Disable-WindowsOptionalFeature` の報告多数。
  * 一部のユーザーは「BIOSでUSB給電設定を切ることで応急的に回避」しているが、根本はWSL/VirtualMachinePlatformが電源管理にフックするのが原因。

---



**Docker Desktopをアンインストール**
→ WSL2を再び有効化しないための抜本対応。

**BIOS/UEFIで「USB always on」「ErP Ready」を調整**
→ これは根本対処ではなく通電を止める応急措置。

**Windowsの「高速スタートアップ」をオフ**
→ 一部では効果があったという報告も（ただし、ほとんどの場合WSLが原因）。

**レガシーHyper-Vに切り替える**
→ Docker Desktopの設定で「Use the WSL2 based engine」をオフ。

