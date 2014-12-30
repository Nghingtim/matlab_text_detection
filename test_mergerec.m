load('qrec.mat','qrec');
for i=1:length(qrec)
    all_rec{1,i}= [qrec{i};mrec{i}];
end
save('all_rec.mat','all_rec');