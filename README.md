# -
研究で圧縮センシングを用いたシングルピクセルイメージングを行っているのだが、
DMDを制御に使う白黒のbmp画像を作らなければならなかったのでアルゴリズムを作った

今回は以下のような制約から画像を作る
i.   アダマール行列の直積をランダムに並べかえたものを使う(白と黒の数を大体同じにするため)
ii.  iに従って作った行列から画像を作る
iii. ノイズを減らすため普通の画像と白黒反転の画像を作る
iv.  画像を作るのに使った行列はReconstructionする際に必要となるため保存しておく
