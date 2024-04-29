function [name] = nameSet() %because terminal input is required
    imshow(ones(2000)) 
    [y,Fs] = audioread('select.wav'); %(from https://sfxr.me)
    selectSound = audioplayer(y,Fs);
    select = 1;
    choose = true;
    text(1100,1200,'Yes','FontSize',40)
    text(700,1200,'No','FontSize',40, 'Color', 'b')

    while choose
        text(500,800,'Enter a name?','FontSize',40)
        waitforbuttonpress
        userInput=double(get(gcf,'CurrentCharacter'));
        switch userInput
            case 29 %right
                imshow(ones(2000)) 
                text(700,1200,'No','FontSize',40)
                text(1100,1200,'Yes','FontSize',40, 'Color', 'b')
                play(selectSound)
                select = 2;
            case 28 %left
                imshow(ones(2000)) 
                text(1100,1200,'Yes','FontSize',40)
                text(700,1200,'No','FontSize',40, 'Color', 'b')
                play(selectSound)
                select = 1;
            case {13,32} %enter or space
                choose = false;
        end
    end
    switch select
        case 1
            name = "Player";
            return
        case 2
            imshow(ones(2000)) 
            text(200,1000,'Enter in mablab terminal','FontSize',40)
            name = input("Enter name: ", 's');
    end
end