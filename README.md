# 本アプリケーションについて
* 筋トレに特化したToDoアプリ+SNSのWebアプリケーションです
* まだ未完成ですが、サーバサイドではRailsを利用しています
* グラフの描画にはChart.jsを利用しています。
# 本アプリケーションの目的について
私が考える本アプリケーションの作成者の目的についてです.
* 自身の筋トレ頻度と成果をグラフィカルに管理したい
* 自身の筋トレをシェアすることで筋トレを続けることのモチベーションとしたい
* 他の人の筋トレメニューを参照することで、トレーニングの質を向上させたい
* 普段の業務ですることはできないアプリケーションの開発をしたい

# 本アプリケーションの運用ポリシー
* パスワード漏洩を考慮し、アプリケーションに登録していただいたパスワードはハッシュ値で登録しておリます
* インフラ基盤AWSへの実装後、BurpSuiteフリー版を用いてペネグレーションテストを行います。
* 障害発生時もしくは攻撃を検知した場合には、検知後可能な限り本サービスを停止させます。

