function [tS_temp, dataarray]=read_TCEQ_func(dirname,filename,formatSpec,start_over)
tS_temp=[];
dataarray=[];
header_num=5; %if reading from beginning of file there are 5 headers
if start_over==1
    offset=50000000; %Number of bytes to move
else
    offset=1000000; %Number of bytes to move
end
fid = fopen([dirname,filename]);
filename
fseek(fid,-offset,'eof');        %# Seek to the file end, minus the offset
C = textscan(fid,formatSpec,'Delimiter',',');%,...
fclose(fid);

timestamp=C{1};
tS_temp=cellfun(@datenum, timestamp(header_num:end));
for col=2:length(C)
    dataarray(:,col) = cell2mat(cellfun(@str2double,C{col},'UniformOutput',0));
    
end
dataarray=dataarray(header_num:end,:);