%�����128 x 128pixcel�̉摜��z�肵�Ă��邽�߁A�T�C�Y�ɉ����ĕς���
%�Ⴆ��64 x 64pixcel�Ȃ�128��64, 16384 �� 4096

%//�A�_�}�[���̒�`
a=[1 1;1 -1];

%//�A�_�}�[���̒���H_n(�摜�T�C�Y�ɉ����Ē��ς̐���ς���)
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


%//�d���̂Ȃ������_��������������(1�`���̐���,1�s����)
rng('shuffle');
random_number1=randperm(16384,16384);

%//for���̌J��Ԃ���(��pixel�ɂ��邩)
w=16384;

%//�\���̂��g����B{x}�Ƀ����_���ɗ��ۑ�(��������_���ɕ��ёւ��鑀��)
Structure = cell(1,w);
for g=1:w
A = random_number1(1,g);
structure{g}=H_n(:,A);
end


%//w�~w�̍s������(��������_���ɕ��ёւ����s��)
column_random_matrix= horzcat(structure{1},structure{2});
for i=3:w
column_random_matrix= horzcat(column_random_matrix,structure{i});
end

%//c���̉摜�𐶐�(���k��)�A�������ɂ����炷���Ƃ͂ł���
c=8000;

%//randperm(n^2-1,c) 1���ڂ̉摜�𔲂�(�S����������)
rng('shuffle');
random_number2=randperm(16383,8000);
random_number2=ones(1,8000)+random_number2;

%�ۑ��`���̐ݒ�
rootname1 = 'DMimage'; % �t�@�C�����Ɏg�p���镶����
extension1 = '.bmp'; % �g���q
rootname2 = 'InvDMimage'; % �t�@�C�����Ɏg�p���镶����
extension2 = '.bmp'; % �g���q

%��������_���ɕ��ёւ����s�񂩂�s�������_���Ɏ����Ă��ă����_���s������
for p=1:c
    line = random_number2(1,p);
    random_matrix{p} = column_random_matrix(line,:);
    random_matrix2=reshape(random_matrix{p},[128,128]); %n^2�s��(n,n)�s��ɕ��ёւ���

    %�s�񂩂�摜�����(�m�[�}���p�^�[���摜�Ɣ��]�p�^�[���摜)
    transpose =random_matrix2.';
    reverse = - transpose;
    nomal= transpose > 0;
    inverse= reverse > 0;

    %�摜�̊g��(1pixel�̒�`��ς���)
    all_1= ones(8);
    nomal2= kron(nomal,all_1);
    inverse2= kron(inverse,all_1);

     
    % �t�@�C���ւ̕ۑ�(bitmap�t�@�C���ŕۑ�)
nomal_fin=mat2gray(nomal2);
inverse_fin=mat2gray(inverse2);

    % �m�[�}���p�^�[���摜�̕ۑ�
filename1 = [rootname1, num2str(p), extension1]; % �C���[�W�t�@�C�����̍쐬
imwrite(nomal_fin,filename1); 
    % ���]�p�^�[���摜�̕ۑ�
filename2 = [rootname2, num2str(p), extension2]; % ���]�C���[�W�t�@�C�����̍쐬
imwrite(inverse_fin,filename2);     

end

%�摜��������ۂ̃p�^�[���s���ۑ����Ă���
originDMmatrix= vertcat(random_matrix{1},random_matrix{2});
for k=3:c
originDMmatrix= vertcat(originDMmatrix,random_matrix{k});
end
    %-1,1�ō\�����ꂽ�s���1,0�ō\�����ꂽ�s��̓��ۑ�����
originDMmatrix;
originDM0up = originDMmatrix > 0;


save('originDMmatrix.mat','originDMmatrix');
save('originDM0up.mat','originDM0up');


