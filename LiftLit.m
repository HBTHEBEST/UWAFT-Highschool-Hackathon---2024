classdef LiftLit < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        Step_Tracker                    matlab.ui.container.Tab
        DistanceTraveledEditField       matlab.ui.control.NumericEditField
        DistanceTraveledEditFieldLabel  matlab.ui.control.Label
        StrideLengthEditField           matlab.ui.control.NumericEditField
        StrideLengthEditFieldLabel      matlab.ui.control.Label
        UIAxes_2                        matlab.ui.control.UIAxes
        Tab2                            matlab.ui.container.Tab
        Tab3                            matlab.ui.container.Tab
        Button                          matlab.ui.control.Button
        TextArea                        matlab.ui.control.TextArea
        TextAreaLabel                   matlab.ui.control.Label
        Panel                           matlab.ui.container.Panel
        Label3                          matlab.ui.control.Label
        Label2                          matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        Image                           matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Button
        function ButtonPushed(app, event)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 480];

            % Create Step_Tracker
            app.Step_Tracker = uitab(app.TabGroup);
            app.Step_Tracker.Title = 'Tab';

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.Step_Tracker);
            title(app.UIAxes_2, 'Title')
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.Position = [266 84 333 345];

            % Create StrideLengthEditFieldLabel
            app.StrideLengthEditFieldLabel = uilabel(app.Step_Tracker);
            app.StrideLengthEditFieldLabel.HorizontalAlignment = 'right';
            app.StrideLengthEditFieldLabel.Position = [15 407 76 22];
            app.StrideLengthEditFieldLabel.Text = 'Stride Length';

            % Create StrideLengthEditField
            app.StrideLengthEditField = uieditfield(app.Step_Tracker, 'numeric');
            app.StrideLengthEditField.Position = [106 407 100 22];

            % Create DistanceTraveledEditFieldLabel
            app.DistanceTraveledEditFieldLabel = uilabel(app.Step_Tracker);
            app.DistanceTraveledEditFieldLabel.HorizontalAlignment = 'right';
            app.DistanceTraveledEditFieldLabel.Position = [15 361 104 22];
            app.DistanceTraveledEditFieldLabel.Text = 'Distance Traveled ';

            % Create DistanceTraveledEditField
            app.DistanceTraveledEditField = uieditfield(app.Step_Tracker, 'numeric');
            app.DistanceTraveledEditField.Position = [134 361 100 22];

            % Create Tab2
            app.Tab2 = uitab(app.TabGroup);
            app.Tab2.Title = 'Tab2';

            % Create Tab3
            app.Tab3 = uitab(app.TabGroup);
            app.Tab3.Title = 'Tab3';

            % Create Panel
            app.Panel = uipanel(app.Tab3);
            app.Panel.Position = [1 278 638 177];

            % Create Image
            app.Image = uiimage(app.Panel);
            app.Image.Position = [34 50 100 100];

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.Position = [166 128 34 22];

            % Create Label2
            app.Label2 = uilabel(app.Panel);
            app.Label2.Position = [166 50 41 22];
            app.Label2.Text = 'Label2';

            % Create Label3
            app.Label3 = uilabel(app.Panel);
            app.Label3.Position = [166 89 41 22];
            app.Label3.Text = 'Label3';

            % Create TextAreaLabel
            app.TextAreaLabel = uilabel(app.Tab3);
            app.TextAreaLabel.HorizontalAlignment = 'right';
            app.TextAreaLabel.Position = [566 183 55 22];
            app.TextAreaLabel.Text = 'Text Area';

            % Create TextArea
            app.TextArea = uitextarea(app.Tab3);
            app.TextArea.Position = [17 212 605 55];

            % Create Button
            app.Button = uibutton(app.Tab3, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.HorizontalAlignment = 'right';
            app.Button.Position = [-74 113 388 82];

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