%今回は128 x 128pixcelの画像を想定しているため、サイズに応じて変える
%例えば64 x 64pixcelなら128→64, 16384 → 4096

%//アダマールの定義
a=[1 1;1 -1];

%//アダマールの直積H_n(画像サイズに応じて直積の数を変える)
H_n = kron(a,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);
H_n = kron(H_n,a);


%//重複のないランダム整数乱数発生(1～ｎの整数,1行ｍ列)
rng('shuffle');
random_number1=randperm(16384,16384);

%//for文の繰り返し回数(何pixelにするか)
w=16384;

%//構造体を使ってB{x}にランダムに列を保存(列をランダムに並び替える操作)
Structure = cell(1,w);
for g=1:w
A = random_number1(1,g);
structure{g}=H_n(:,A);
end


%//w×wの行列を作る(列をランダムに並び替えた行列)
column_random_matrix= horzcat(structure{1},structure{2});
for i=3:w
column_random_matrix= horzcat(column_random_matrix,structure{i});
end

%//c枚の画像を生成(圧縮率)、復元時にも減らすことはできる
c=8000;

%//randperm(n^2-1,c) 1枚目の画像を抜く(全部白だから)
rng('shuffle');
random_number2=randperm(16383,8000);
random_number2=ones(1,8000)+random_number2;

%保存形式の設定
rootname1 = 'DMimage'; % ファイル名に使用する文字列
extension1 = '.bmp'; % 拡張子
rootname2 = 'InvDMimage'; % ファイル名に使用する文字列
extension2 = '.bmp'; % 拡張子

%列をランダムに並び替えた行列から行をランダムに持ってきてランダム行列を作る
for p=1:c
    line = random_number2(1,p);
    random_matrix{p} = column_random_matrix(line,:);
    random_matrix2=reshape(random_matrix{p},[128,128]); %n^2行を(n,n)行列に並び替える

    %行列から画像を作る(ノーマルパターン画像と反転パターン画像)
    transpose =random_matrix2.';
    reverse = - transpose;
    nomal= transpose > 0;
    inverse= reverse > 0;

    %画像の拡大(1pixelの定義を変える)
    all_1= ones(8);
    nomal2= kron(nomal,all_1);
    inverse2= kron(inverse,all_1);

     
    % ファイルへの保存(bitmapファイルで保存)
nomal_fin=mat2gray(nomal2);
inverse_fin=mat2gray(inverse2);

    % ノーマルパターン画像の保存
filename1 = [rootname1, num2str(p), extension1]; % イメージファイル名の作成
imwrite(nomal_fin,filename1); 
    % 反転パターン画像の保存
filename2 = [rootname2, num2str(p), extension2]; % 反転イメージファイル名の作成
imwrite(inverse_fin,filename2);     

end

%画像を作った際のパターン行列を保存しておく
originDMmatrix= vertcat(random_matrix{1},random_matrix{2});
for k=3:c
originDMmatrix= vertcat(originDMmatrix,random_matrix{k});
end
    %-1,1で構成された行列と1,0で構成された行列の二つを保存する
originDMmatrix;
originDM0up = originDMmatrix > 0;


save('originDMmatrix.mat','originDMmatrix');
save('originDM0up.mat','originDM0up');


