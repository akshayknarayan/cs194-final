% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

function main()
    result = create_hdr_image(50, 0.09, 1.0, 'station', 'jpg');
    figure, imshow(result);
end