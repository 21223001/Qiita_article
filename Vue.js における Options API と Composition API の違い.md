

## In a nutshell
Vue.js には主に Options API と Composition API の2つの記述方法がある．前者は学びやすく，後者は拡張性や再利用性に優れる．プロジェクトの規模や目的に応じて使い分けることが重要である．


## はじめに
Vue.jsについて学ぶ際に，最初に困ったのが Options API と，Composition APIだった．両者の違いについて改めて理解をする為に，以下の記事として概要を纏めた．


## 予想される読み手
 - Vue.js について初学者であり，学びたい
 - 将来的にフロントエンド開発に携わる予定のある人


## 1. Options API

Options API とは，Vue 2 系まで主に使用されていた記述スタイルであり，コンポーネントの構成要素を `data`, `methods`, `computed`, `watch` などの「オプション」として分けて記述する方式である．

### 特徴

- コンポーネントの構成が明確で読みやすい  
- 初学者にとって直感的で理解しやすい  
- 複数の機能が絡み合う場合，処理の見通しが悪くなりやすい  
- 複雑なロジックの再利用が難しい（共通処理の切り出しが困難）

### 実例（カウント機能）

```vue
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="increment">+1</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      count: 0
    }
  },
  methods: {
    increment() {
      this.count++
    }
  }
}
</script>
```

このように，状態 (`count`) は `data()` に，動作 (`increment`) は `methods` に定義する．構造が明確であり，小規模なプロジェクトでは特に有効である．



## 2. Composition API
Composition API は，Vue 3 系で導入された新しい記述スタイルである．ロジックを `setup()` 関数や `<script setup>` の中に記述し，関連する状態と振る舞いを関心ごとにまとめることができる．

### 特徴

- 状態とロジックを同じスコープに定義できるため，見通しが良い  
- 機能単位でコードを整理できるため，大規模開発に向いている  
- 関数として切り出しやすく，ロジックの再利用性が高い（Composable）  
- TypeScript との相性が良く，型安全な開発がしやすい  
- 初学者にはやや抽象度が高く，慣れるまでに時間を要する  

### 実例（カウント機能）

```vue
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="increment">+1</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const count = ref(0)

function increment() {
  count.value++
}
</script>
```

`ref()` を用いてリアクティブな状態を定義し，関数も同じスコープ内で記述することで，処理がまとまりやすくなる．



## 両者の比較表

| 項目                   | Options API                             | Composition API                            |
|------------------------|------------------------------------------|--------------------------------------------|
| 導入バージョン         | Vue 2 〜                                | Vue 3 〜                                   |
| コードの分離方法       | 機能ごとに分離（`data`, `methods` など）| 関心ごとに分離（状態と処理を同じ場所に） |
| ロジックの再利用性     | 低い                                    | 高い（Composable 関数の利用が可能）      |
| TypeScript との相性    | 普通                                    | 非常に良い                                 |
| 初学者への分かりやすさ | 高い                                    | やや難しい                                 |


## どちらを使うべきなのか

 - 学習初期や小〜中規模のプロジェクトでは Options API を選ぶと，学習コストが低く始めやすい．  
 - 機能の再利用性やロジックの整理が重要な 中〜大規模プロジェクトでは Composition API を選ぶことでメリットが大きい．  
 - Vue 3 では，どちらの記法も利用可能であり，両者を併用することも可能である．．

 - 初学者にとっては Options API の方が理解しやすいとされているが，個人の考えとして，今後のスキル拡張性，柔軟性を担保するという観点ではComposition API に早い段階で慣れておく方が良いと感じている．

## Summary

 - Options API は Vue 2 系で使用されていた，直感的な記述方法である
 - Composition API は Vue 3 で導入され，柔軟かつ再利用しやすい
 - 小規模な学習用途では Options API が適している
 - 大規模開発や TypeScript との連携を意識するなら Composition API が有利
 - 両者は Vue 3 において共存でき，プロジェクトに応じた選択が可能
 - 将来の技術拡張性を考慮し，Composition API に慣れるのも一つの選択肢である

## References

[Vue.js GUIDE Getting Started Introduction](https://vuejs.org/guide/introduction.html)
[Vue.js GUIDE Extra Topics Composition API FAQ](https://vuejs.org/guide/extras/composition-api-faq.html)













