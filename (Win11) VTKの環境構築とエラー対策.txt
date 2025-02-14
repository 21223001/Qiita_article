VTKに関する環境構築について、大変時間を使ったので、記録

結果として、pythonのpipで一発OKだった。
```
pip install vtk
```


#### 自分の環境
OS : Windows 11
CPU : AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx 2.10 GHz
Python : 3.9.21
conda version : 24.11.2
VTKバージョン: 9.3.1  

#### VTKの使い道
植物細胞の膨圧や境界張力を含んだシミュレーションの可視化に用いる．

https://royalsocietypublishing.org/doi/10.1098/rsif.2023.0173#d1e2435


![frame_00000.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/0a649954-cdd4-8248-120e-0e7c393e05fb.png)


### 試した事
以下のいずれにせよ，コンパイル&ビルドには時間がかかる．
使用コア7つの並列ビルドで1時間を軽く超えるので，非常に面倒．

#### 成功した方法
pipでインストール


#### 失敗した方法
MINGW64でCmake
毎回、lib-tiff関係で必ずエラーが生じた。
依存関係の解消やlib-tiffに関連する機能を落としてコンパイルするなど、色々試してビルドの終了まで持っていくが、VTKにおける必須のファイルたちがなぜか生成されていなかった
CMakeLists.txtの修正をしたが，時間だけが無くなる
VTKのバージョンについても複数試した．

<details><summary>詳細</summary>

1. MINGW64でのVTK構築
コマンド:
mingw32-make -j6
結果: multiple definition of `vtktiff__TIFFerrorHandlerExt' エラー発生
原因: TIFFモジュールの競合
2. CMakeによる依存関係の整理
コマンド:
pacman -S mingw-w64-x86_64-libtiff mingw-w64-x86_64-cmake
結果: TIFFモジュールのエラーが継続
3. TIFFモジュール無効化の試行
コマンド:
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DModule_vtktiff=OFF "C:/Users/user/Downloads/VTK-master"
結果: TIFFモジュールの無効化でエラーは解消されず
4. 再度のビルド（スレッド数を減らす）
コマンド:
mingw32-make -j4
結果: 同様のエラーが発生
5. 内部TIFFモジュールの削除と再試行
コマンド:
rm -rf C:/Users/user/Downloads/VTK-master/ThirdParty/tiff/vtktiff
結果: 内部TIFFモジュールが競合しているため、ビルドが失敗
6. 外部ライブラリの強制使用
コマンド:
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DVTK_USE_SYSTEM_TIFF=ON -DTIFF_INCLUDE_DIR=C:/msys64/mingw64/include -DTIFF_LIBRARY=C:/msys64/mingw64/lib/libtiff.dll.a "C:/Users/user/Downloads/VTK-master"
結果: TIFFモジュールに関するエラーが解消されず
7. ビルド環境の整備（必要なパッケージのインストール）
コマンド:
pacman -S mingw-w64-x86_64-binutils mingw-w64-x86_64-gcc
結果: エラーが解消せず、ビルドは未完了
8. Ninjaによる再試行
コマンド:
cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DTIFF_INCLUDE_DIR=/mingw64/include -DTIFF_LIBRARY=/mingw64/lib/libtiff.dll.a -DVTK_USE_SYSTEM_TIFF=ON ../vtk
結果: TIFFエラーが解消されず、ビルドに失敗
9. NetCDF無効化の試行
コマンド:
cmake -G Ninja -DVTK_MODULE_ENABLE_VTK_netcdf=NO
結果: NetCDFエラーが解消されず
</details>


VisualStudioでVTKを構築
残念な事に，VisualStudioの使い方がよく分からなかった．
VisualStudioでも可能ではあったのかもしれないが検証までは出来ていない．

conda-forgeでインストール
numpy関係のエラーが生じた


#### 上手くいった方法
pythonのvtkライブラリを利用する．
anaconda経由でインストールすると，numpy関係でエラーが生じる．
したがって，pipでインストールした．
vtkのバージョンは9.3.1

<details><summary>実行したコマンドの履歴</summary>

```
conda環境及びVTKのインストール
conda create -n vtk_env python=3.9
conda activate vtk_env

conda install -c conda-forge cmake
conda install -c conda-forge vtk
(error)conda install -c conda-forge mingw-w64
(error)conda install -c conda-forge mingw-w64-toolchain
conda install -c conda-forge m2w64-toolchain

VTKが上手く入っていないので，一旦，baseとvtk_envのvtkをremoveしてから，vtk_envだけに入れる

conda remove vtk

conda config --add channels conda-forge
conda config --set channel_priority strict


これを見ると，インストールは成功していそう
(vtk_env) C:\Users\user>python -c "import vtk; print(vtk.vtkVersion().GetVTKVersion())"
9.3.1

下に胚ってそう
"C:\Users\user\anaconda3\envs\vtk_env\Lib\site-packages\vtkmodules"

conda activate vtk_env
(vtk_env)を確認


VTKはpipでインストール
condaとpipのインストール状況を確認
conda list vtk
pip show vtk

conda remove vtk
pip uninstall vtk


conda install pip
pip install vtk==9.3.1


numpyでエラー
anaconda3フォルダに飛んで，手動でnumpy関係フォルダを削除(2フォルダ)

再度，pipでnumpyとvtkをインストール
```
</details>

参考として，conda と pip を分けて依存関係を記述

```
conda list > conda_packages.txt
pip list --format=columns > pip_packages.txt
```


conda

```
# Name                    Version                   Build  Channel
bzip2                     1.0.8                h2466b09_7    conda-forge
ca-certificates           2024.12.14           h56e8100_0    conda-forge
cmake                     3.31.4               hff78f93_0    conda-forge
contourpy                 1.3.0                    pypi_0    pypi
cycler                    0.12.1                   pypi_0    pypi
fonttools                 4.55.3                   pypi_0    pypi
importlib-resources       6.5.2                    pypi_0    pypi
kiwisolver                1.4.7                    pypi_0    pypi
krb5                      1.21.3               hdf4eb48_0    conda-forge
libcurl                   8.11.1               h88aaa65_0    conda-forge
libexpat                  2.6.4                he0c23c2_0    conda-forge
libffi                    3.4.2                h8ffe710_5    conda-forge
liblzma                   5.6.3                h2466b09_1    conda-forge
libsqlite                 3.47.2               h67fdade_0    conda-forge
libssh2                   1.11.1               he619c9f_0    conda-forge
libuv                     1.49.2               h2466b09_0    conda-forge
libzlib                   1.3.1                h2466b09_2    conda-forge
m2w64-binutils            2.25.1                        5    conda-forge
m2w64-bzip2               1.0.6                         6    conda-forge
m2w64-crt-git             5.0.0.4636.2595836               2    conda-forge
m2w64-gcc                 5.3.0                         6    conda-forge
m2w64-gcc-ada             5.3.0                         6    conda-forge
m2w64-gcc-fortran         5.3.0                         6    conda-forge
m2w64-gcc-libgfortran     5.3.0                         6    conda-forge
m2w64-gcc-libs            5.3.0                         7    conda-forge
m2w64-gcc-libs-core       5.3.0                         7    conda-forge
m2w64-gcc-objc            5.3.0                         6    conda-forge
m2w64-gmp                 6.1.0                         2    conda-forge
m2w64-headers-git         5.0.0.4636.c0ad18a               2    conda-forge
m2w64-isl                 0.16.1                        2    conda-forge
m2w64-libiconv            1.14                          6    conda-forge
m2w64-libmangle-git       5.0.0.4509.2e5a9a2               2    conda-forge
m2w64-libwinpthread-git   5.0.0.4634.697f757               2    conda-forge
m2w64-make                4.1.2351.a80a8b8               2    conda-forge
m2w64-mpc                 1.0.3                         3    conda-forge
m2w64-mpfr                3.1.4                         4    conda-forge
m2w64-pkg-config          0.29.1                        2    conda-forge
m2w64-toolchain           5.3.0                         7    conda-forge
m2w64-tools-git           5.0.0.4592.90b8472               2    conda-forge
m2w64-windows-default-manifest 6.4                           3    conda-forge
m2w64-winpthreads-git     5.0.0.4634.697f757               2    conda-forge
m2w64-zlib                1.2.8                        10    conda-forge
matplotlib                3.9.4                    pypi_0    pypi
msys2-conda-epoch         20160418                      1    conda-forge
numpy                     2.0.2                    pypi_0    pypi
openssl                   3.4.0                ha4e3fda_1    conda-forge
packaging                 24.2                     pypi_0    pypi
pillow                    11.1.0                   pypi_0    pypi
pip                       24.3.1             pyh8b19718_2    conda-forge
pyparsing                 3.2.1                    pypi_0    pypi
python                    3.9.21          h37870fc_1_cpython    conda-forge
python-dateutil           2.9.0.post0              pypi_0    pypi
setuptools                75.6.0             pyhff2d567_1    conda-forge
six                       1.17.0                   pypi_0    pypi
tk                        8.6.13               h5226925_1    conda-forge
tzdata                    2024b                hc8b5060_0    conda-forge
ucrt                      10.0.22621.0         h57928b3_1    conda-forge
vc                        14.40                haa95532_2  
vc14_runtime              14.42.34433         he29a5d6_23    conda-forge
vs2015_runtime            14.42.34433         hdffcdeb_23    conda-forge
vtk                       9.3.1                    pypi_0    pypi
wheel                     0.45.1             pyhd8ed1ab_1    conda-forge
zipp                      3.21.0                   pypi_0    pypi
zstd                      1.5.6                h0ea2cb4_0    conda-forge
```


pip
```
Package             Version
------------------- -----------
contourpy           1.3.0
cycler              0.12.1
fonttools           4.55.3
importlib_resources 6.5.2
kiwisolver          1.4.7
matplotlib          3.9.4
numpy               2.0.2
packaging           24.2
pillow              11.1.0
pip                 24.3.1
pyparsing           3.2.1
python-dateutil     2.9.0.post0
setuptools          75.6.0
six                 1.17.0
vtk                 9.3.1
wheel               0.45.1
zipp                3.21.0
```




