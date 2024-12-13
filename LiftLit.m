classdef LiftLit_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        Step_Tracker                    matlab.ui.container.Tab
        NumberofStepsLabel              matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        DistanceTraveledEditField       matlab.ui.control.NumericEditField
        DistanceTraveledEditFieldLabel  matlab.ui.control.Label
        UIAxes_2                        matlab.ui.control.UIAxes
        CalenderTab                     matlab.ui.container.Tab
        ProfileTab                      matlab.ui.container.Tab
        AboutButton                     matlab.ui.control.Button
        NotificationsButton             matlab.ui.control.Button
        SupportButton                   matlab.ui.control.Button
        AccessibilityButton             matlab.ui.control.Button
        TipsuserguideButton             matlab.ui.control.Button
        AveryimportantPersonTextArea    matlab.ui.control.TextArea
        AveryimportantPersonTextAreaLabel  matlab.ui.control.Label
        ACCOUNTCENTREPanel              matlab.ui.container.Panel
        WorkoutscompletedLabel          matlab.ui.control.Label
        DatejoinedddmmyyyyyLabel        matlab.ui.control.Label
        NameLabel                       matlab.ui.control.Label
        Image                           matlab.ui.control.Image
    end

    
    methods (Access = private)
        
        function results = func(app)
           load('ExampleData.mat');%get data from a smart watch 

           lat=Position.latitude;
           lon=Position.Longitude;
           positionDatetime=Position.Timestamp;

           Xacc= Acceleration.X;%In order to find more distance stuff
           Yacc= Accelration.Y;
           Zacc= Acceleration.Z;
           accelDateTime=Acceleration.Timestamp;

           positionTime=timeElasped(positionDatetime);
           accelTime=timeElasped(accelDatetime);
            
           earthCirc=24901;
           totaldis=0; 

           %finding the distance 
           for i=1:(length(lat)-1)
               lat1=lat(i);
               lat2=lat(i+1);
               lon1=lon(i);
               lon2=lon(i+1);

               degDis=distance(lat1,lon1,lat2,lon2);%mat labs distance feature (we stan) 
               dis=(degDis/360)*earthCirc;
               totaldis=totaldis+dis; %because mat lab does like += apparently 
           end
           stride=2.5;%apparently this is the average stride in feat
           totaldis_ft=totaldis*5200; %converts total dis to feet 
           steps=totaldis_ft/stride; %assuming that stride is regular this is certainly a way to figure out total steps as steps*stride length=distance traveled 

           disp("you took",num2str(steps) ,"steps");%displays distances 

        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: TipsuserguideButton
        function TipsuserguideButtonPushed(app, event)

        end

        % Value changed function: DistanceTraveledEditField
        function DistanceTraveledEditFieldValueChanged(app, event)
           value = app.DistanceTraveledEditField.Value;
           stride=2.5;%apparently this is the average stride in feat
           steps=value/stride; %assuming that stride is regular this is certainly a way to figure out total steps as steps*stride length=distance traveled 


           app.Label.Text= num2str(steps);%displays distances 

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 480];

            % Create Step_Tracker
            app.Step_Tracker = uitab(app.TabGroup);
            app.Step_Tracker.Title = 'Step';

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.Step_Tracker);
            title(app.UIAxes_2, 'Title')
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.Position = [266 84 333 345];

            % Create DistanceTraveledEditFieldLabel
            app.DistanceTraveledEditFieldLabel = uilabel(app.Step_Tracker);
            app.DistanceTraveledEditFieldLabel.HorizontalAlignment = 'right';
            app.DistanceTraveledEditFieldLabel.Position = [16 382 104 22];
            app.DistanceTraveledEditFieldLabel.Text = 'Distance Traveled ';

            % Create DistanceTraveledEditField
            app.DistanceTraveledEditField = uieditfield(app.Step_Tracker, 'numeric');
            app.DistanceTraveledEditField.ValueChangedFcn = createCallbackFcn(app, @DistanceTraveledEditFieldValueChanged, true);
            app.DistanceTraveledEditField.Position = [135 382 100 22];

            % Create Label
            app.Label = uilabel(app.Step_Tracker);
            app.Label.Position = [135 338 25 22];
            app.Label.Text = '___';

            % Create NumberofStepsLabel
            app.NumberofStepsLabel = uilabel(app.Step_Tracker);
            app.NumberofStepsLabel.Position = [27 338 95 22];
            app.NumberofStepsLabel.Text = 'Number of Steps';

            % Create CalenderTab
            app.CalenderTab = uitab(app.TabGroup);
            app.CalenderTab.Title = 'Calender';

            % Create ProfileTab
            app.ProfileTab = uitab(app.TabGroup);
            app.ProfileTab.Title = 'Profile';

            % Create ACCOUNTCENTREPanel
            app.ACCOUNTCENTREPanel = uipanel(app.ProfileTab);
            app.ACCOUNTCENTREPanel.TitlePosition = 'centertop';
            app.ACCOUNTCENTREPanel.Title = 'ACCOUNT CENTRE';
            app.ACCOUNTCENTREPanel.FontName = 'Trebuchet MS';
            app.ACCOUNTCENTREPanel.FontSize = 24;
            app.ACCOUNTCENTREPanel.Position = [1 278 638 177];

            % Create Image
            app.Image = uiimage(app.ACCOUNTCENTREPanel);
            app.Image.Position = [26 21 100 100];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'Generic App Logo.png');

            % Create NameLabel
            app.NameLabel = uilabel(app.ACCOUNTCENTREPanel);
            app.NameLabel.FontName = 'Comic Sans MS';
            app.NameLabel.FontSize = 24;
            app.NameLabel.Position = [149 89 117 32];
            app.NameLabel.Text = 'Name';

            % Create DatejoinedddmmyyyyyLabel
            app.DatejoinedddmmyyyyyLabel = uilabel(app.ACCOUNTCENTREPanel);
            app.DatejoinedddmmyyyyyLabel.Position = [147 58 145 27];
            app.DatejoinedddmmyyyyyLabel.Text = 'Date joined | dd/mm/yyyyy';

            % Create WorkoutscompletedLabel
            app.WorkoutscompletedLabel = uilabel(app.ACCOUNTCENTREPanel);
            app.WorkoutscompletedLabel.Position = [147 32 131 27];
            app.WorkoutscompletedLabel.Text = 'Workouts completed | #';

            % Create AveryimportantPersonTextAreaLabel
            app.AveryimportantPersonTextAreaLabel = uilabel(app.ProfileTab);
            app.AveryimportantPersonTextAreaLabel.HorizontalAlignment = 'right';
            app.AveryimportantPersonTextAreaLabel.Position = [484 192 137 22];
            app.AveryimportantPersonTextAreaLabel.Text = '-A very important Person';

            % Create AveryimportantPersonTextArea
            app.AveryimportantPersonTextArea = uitextarea(app.ProfileTab);
            app.AveryimportantPersonTextArea.Position = [17 221 605 46];
            app.AveryimportantPersonTextArea.Value = {'"Quote"'};

            % Create TipsuserguideButton
            app.TipsuserguideButton = uibutton(app.ProfileTab, 'push');
            app.TipsuserguideButton.ButtonPushedFcn = createCallbackFcn(app, @TipsuserguideButtonPushed, true);
            app.TipsuserguideButton.HorizontalAlignment = 'right';
            app.TipsuserguideButton.Position = [16 156 607 29];
            app.TipsuserguideButton.Text = 'Tips & user guide >';

            % Create AccessibilityButton
            app.AccessibilityButton = uibutton(app.ProfileTab, 'push');
            app.AccessibilityButton.HorizontalAlignment = 'right';
            app.AccessibilityButton.Position = [16 128 607 29];
            app.AccessibilityButton.Text = 'Accessibility >';

            % Create SupportButton
            app.SupportButton = uibutton(app.ProfileTab, 'push');
            app.SupportButton.HorizontalAlignment = 'right';
            app.SupportButton.Position = [16 100 607 29];
            app.SupportButton.Text = 'Support >';

            % Create NotificationsButton
            app.NotificationsButton = uibutton(app.ProfileTab, 'push');
            app.NotificationsButton.HorizontalAlignment = 'right';
            app.NotificationsButton.Position = [16 72 607 29];
            app.NotificationsButton.Text = 'Notifications >';

            % Create AboutButton
            app.AboutButton = uibutton(app.ProfileTab, 'push');
            app.AboutButton.HorizontalAlignment = 'right';
            app.AboutButton.Position = [16 44 607 29];
            app.AboutButton.Text = 'About >';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LiftLit_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end