forenamelen=47;
l_t=length(train);
for i=1:l_t
    e_imgname{i}=strrep(train{i}(forenamelen:end),'/','_');
end
save('e_imgname.mat','e_imgname');
save('e_rec.mat','e_rec')
%%
% test=xml_read('locations.xml');
% l_te=length(test.image);
% for i=1:l_te
%     t_imgname{i}=strrep(test.image(i).imageName,'/','_'); 
%     rect=[];
%     if ~isempty(test.image(i).taggedRectangles)
%         l_tag=length(test.image(i).taggedRectangles.taggedRectangle);
%       
%         for j=1:l_tag
%             he=test.image(i).taggedRectangles.taggedRectangle(j).ATTRIBUTE.height;
%             wi=test.image(i).taggedRectangles.taggedRectangle(j).ATTRIBUTE.width;
%             x=test.image(i).taggedRectangles.taggedRectangle(j).ATTRIBUTE.x;
%             y=test.image(i).taggedRectangles.taggedRectangle(j).ATTRIBUTE.y;
%             re=[x,y,wi,he];
%             rect=[rect;re];
%         end
%         t_rec{i}=rect;
%     else
%         t_rec{i}=[];
%     end
%     
% end
% save('t_rec.mat','t_rec');
% save('t_imgname.mat','t_imgname');
% 
% 
