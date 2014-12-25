load('q_e_rec.mat','q_e_rec');
for i=1:length(e_rec)
    erec{i}=[e_rec{i};q_e_rec{i}];
end
save('erec.mat','erec');