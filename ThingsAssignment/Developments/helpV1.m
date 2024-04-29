function [] = help()
    slides = [1 2 3 4 5];
    currentSlide = 1;
    menuSelect = true;
    imshow(ones(2000))

    while menuSelect
         switch slides(currentSlide)
            case 1
                imshow(ones(2000))
                text(700,800, "Collect coins.","FontSize", 24)
                rectangle('Position',[1300,750,100,100],'FaceColor','y')
                text(500,1000, "Move with Arrow Keys.","FontSize", 24)
                text(700,1200, "Quit with Esc.","FontSize", 24)
                text(1700,1900, 'Next \rightarrow',"FontSize", 14)
            case 2
                imshow(ones(2000))
                text(500,800, "Break walls with space", "FontSize", 24)
                text(150,1000, "then choose a direction twice to confirm.","FontSize", 24)
                text(400,1200, "You have a limited amount.","FontSize", 24)
                text(1700,1900, 'Next \rightarrow',"FontSize", 14)
            case 3
                imshow(ones(2000))
                text(200,800, "Enemies might attack while you travel.","FontSize", 24)
                text(300,1000, "Beat them in Rock Paper Scissors.","FontSize", 24)
                text(100,1200, "They get harder with more coins you have.","FontSize", 24)
                rectangle('Position',[1000,1500,100,100],'FaceColor','r')
                text(1700,1900, 'Next \rightarrow',"FontSize", 14)
            case 4
                imshow(ones(2000))
                text(300,800, "You can get restore wall breaks",'Fontsize', 24)
                text(600,1000,"from the green box","FontSize", 24)
                rectangle('Position',[1500,950,100,100],'FaceColor','g')
                text(500,1200, "Or by defeating enemies.","FontSize", 24)
                text(1700,1900, 'Next \rightarrow',"FontSize", 14)
                text(300,100, 'Back \leftarrow',"FontSize", 14)
            case 5
                imshow(ones(2000))
                text(350,1000, "Win by collecting all the coins.","FontSize", 24)
                text(1700,1900, 'End \rightarrow',"FontSize", 14)
                text(300,100, 'Back \leftarrow',"FontSize", 14)
        end
        waitforbuttonpress
        userInput=double(get(gcf,'CurrentCharacter'));
        switch userInput
            case 27
                return
            case {13,32,29} %space or enter
                if currentSlide ~= length(slides)
                    currentSlide = currentSlide + 1;
                else
                    return
                end
            case {8,28}
                 if currentSlide ~= 1
                    currentSlide = currentSlide - 1;
                 end
        end
    end