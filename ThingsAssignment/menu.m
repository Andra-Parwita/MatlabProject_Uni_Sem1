function [mapSize] = menu()

    [y,Fs] = audioread('select.wav'); %(from https://sfxr.me)
    select = audioplayer(y,Fs);

    imshow(ones(2000)) %Background
    menuOption = [1 2 3];
    menuSelection = 2;
    menuSelect = true;
    finalOption = 20;
    
    %menu selection
    while menuSelect == true
        rectangle('Position',[500,600,1000,250],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
        rectangle('Position',[500,1000,1000,250],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
        rectangle('Position',[500,1400,1000,250],'FaceColor',[1,1,1],'EdgeColor',[0,0,0])
        text(600,350, "MAP SIZE","FontSize", 42)
        text(840,680, "SMALL","FontSize", 24)
        text(900,780, "10x10","FontSize", 16)

        text(800,1080, "MEDIUM","FontSize", 24)
        text(900,1180, "20x20","FontSize", 16)

        text(830,1480, "LARGE","FontSize", 24)
        text(900,1580, "25x25","FontSize", 16)
        switch menuSelection
            case 1
                rectangle('Position',[500,600,1000,250],'FaceColor',[1,1,1],'EdgeColor','b')
                text(840,680, "SMALL","FontSize", 24, 'Color','b')
                text(900,780, "10x10","FontSize", 16, 'Color','b')
            case 2
                rectangle('Position',[500,1000,1000,250],'FaceColor',[1,1,1],'EdgeColor','b')
                text(800,1080, "MEDIUM","FontSize", 24, 'Color','b')
                text(900,1180, "20x20","FontSize", 16, 'Color','b')
            case 3
                rectangle('Position',[500,1400,1000,250],'FaceColor',[1,1,1],'EdgeColor','b')
                text(830,1480, "LARGE","FontSize", 24, 'Color','b')
                text(900,1580, "25x25","FontSize", 16, 'Color','b')
        end
        waitforbuttonpress
        userInput=double(get(gcf,'CurrentCharacter'));
        switch userInput
            case 30 %up
                if menuSelection ~= 1
                    play(select)
                    menuSelection = menuSelection -1;
                end
            case 31 %down
                play(select)
                if menuSelection ~= length(menuOption)
                    menuSelection = menuSelection +1;
                end
            case {13,32} %space or enter
                play(select)
                finalOption = menuSelection;
                menuSelect = false;
        end
    end
    
    %determines map size based on option chosen
    switch finalOption
        case 1
            mapSize = 10;
        case 2
            mapSize = 20;
        case 3
            mapSize = 30;
    end

    %sliding animation
    for i = 1:5
        pause(0.1)
        rectangle('position',[0,0,400*i,2000], 'FaceColor', [0,0,0])
    end
    pause(0.2)


end