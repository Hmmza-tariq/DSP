classdef project < matlab.apps.AppBase

    properties (Access = public)
        MainUIFigure             matlab.ui.Figure
        MagnitudePhaseButton     matlab.ui.control.Button
        PoleZeroPlotButton       matlab.ui.control.Button
        SelectFilterTypeButton   matlab.ui.control.Button 
        DisplayTimeAxes          matlab.ui.control.UIAxes
        DisplayFreqAxes          matlab.ui.control.UIAxes
        FilterOrderLabel         matlab.ui.control.Label
        BrandingLabel            matlab.ui.control.Label
        CoefficientsButton       matlab.ui.control.Button
        FilterOrderSlider        matlab.ui.control.Slider
    end

    properties (Access = private)
        ecgSignal                double
        samplingRate             double = 250;
        currentFilterOrder       double = 5;
        selectedFilter           char = 'Butterworth'; 
        a_coff                   double
        b_coff                   double
    end

    methods (Access = private)

    function onFilteredOutputButtonPushed(app, ~)
        % Load and preprocess ECG signal
        app.ecgSignal=[-114	-111	-109	-109	-107	-110	-110	-110	-115	-114	-113	-110	-110	-109	-111	-114	-113	-110	-110	-109	-108	-109	-108	-112	-114	-112	-109	-106	-105	-107	-111	-110	-116	-113	-109	-108	-105	-108	-110	-107	-111	-110	-107	-104	-102	-98	-99	-101	-107	-110	-109	-100	-95	-88	-90	-93	-98	-103	-106	-109	-108	-107	-107	-111	-116	-113	-113	-112	-109	-108	-105	-106	-108	-110	-114	-114	-112	-109	-108	-109	-110	-113	-114	-111	-110	-105	-102	-102	-102	-95	-85	-59	-18	36	79	99	100	85	52	-9	-32	-192	-268	-289	-263	-220	-180	-155	-140	-134	-124	-117	-118	-116	-115	-114	-115	-114	-110	-108	-105	-107	-109	-108	-109	-110	-105	-106	-106	-107	-105	-109	-112	-106	-106	-103	-101	-105	-105	-108	-109	-106	-105	-102	-98	-101	-104	-103	-109	-105	-106	-103	-96	-96	-96	-94	-95	-98	-94	-90	-84	-81	-79	-78	-77	-80	-75	-72	-67	-65	-64	-61	-62	-65	-62	-60	-58	-53	-53	-53	-55	-62	-68	-68	-72	-74	-76	-83	-90	-95	-104	-109	-110	-108	-110	-110	-116	-120	-120	-124	-124	-122	-119	-117	-121	-122	-126	-128	-128	-126	-126	-123	-124	-124	-127	-131	-129	-129	-122	-122	-120	-124	-123	-127	-125	-125	-123	-121	-120	-117	-118	-122	-121	-121	-121	-114	-112	-113	-116	-117	-122	-119	-120	-116	-111	-115	-115	-117	-121	-123	-121	-121	-119	-118	-120	-121	-125	-126	-126	-123	-124	-122	-122	-122	-127	-128	-130	-129	-127	-122	-124	-127	-127	-132	-131	-130	-128	-123	-123	-127	-128	-131	-131	-130	-127	-125	-122	-125	-125	-126	-128	-128	-127	-124	-125	-122	-122	-128	-128	-130	-128	-126	-125	-120	-123	-124	-126	-129	-126	-125	-120	-118	-120	-122	-123	-127	-127	-125	-126	-120	-121	-122	-123	-128	-127	-125	-118	-116	-116	-118	-121	-123	-122	-128	-127	-122	-116	-118	-119	-124	-123	-127	-122	-119	-116	-117	-117	-120	-123	-124	-124	-122	-118	-119	-117	-118	-120	-125	-122	-121	-120	-118	-118	-117	-120	-123	-123	-123	-119	-118	-118	-117	-119	-120	-120	-121	-115	-111	-103	-107	-112	-117	-118	-116	-111	-105	-102	-101	-107	-113	-119	-123	-122	-117	-117	-117	-118	-120	-119	-124	-125	-120	-119	-115	-119	-118	-122	-124	-122	-118	-119	-114	-116	-114	-117	-118	-118	-114	-111	-107	-101	-91	-72	-37	12	28	67	78	79	76	45	-23	-123	-220	-271	-250	-199	-155	-135	-133	-137	-135	-127	-122	-113	-109	-111	-113	-113	-116	-115	-110	-106	-106	-106	-107	-109	-111	-109	-109	-106	-102	-101	-103	-106	-107	-107	-106	-103	-100	-99	-99	-102	-103	-102	-103	-98	-94	-95	-94	-93	-95	-99	-93	-89	-86	-84	-81	-78	-80	-78	-78	-73	-68	-64	-57	-57	-59	-58	-56	-55	-46	-41	-37	-34	-35	-34	-36	-35	-32	-30	-31	-34	-38	-45	-54	-57	-62	-65	-66	-69	-75	-84	-88	-97	-98	-93	-93	-91	-96	-98	-101	-105	-106	-105	-99	-98	-99	-99	-97	-104	-103	-101	-99	-97	-95	-98	-97	-106	-104	-104	-101	-97	-94	-96	-96	-99	-102	-100	-97	-96	-92	-92	-92	-95	-98	-98	-99	-96	-95	-93	-93	-95	-97	-98	-98	-95	-95	-94	-94	-97	-99	-101	-102	-101	-99	-98	-98	-99	-101	-102	-105	-102	-99	-99	-98	-98	-101	-103	-104	-105	-101	-102	-100	-99	-101	-104	-108	-106	-104	-100	-98	-100	-98	-102	-104	-104	-102	-103	-100	-98	-99	-102	-104	-104	-103	-102	-100	-96	-98	-99	-102	-106	-106	-102	-99	-98	-98	-100	-101	-103	-106	-106	-102	-99	-97	-96	-101	-105	-103	-102	-101	-98	-96	-94	-99	-103	-104	-103	-99	-98	-96	-92	-95	-98	-101	-99	-104	-97	-96	-93	-94	-98	-100	-101	-102	-98	-95	-94	-92	-97	-99	-103	-99	-99	-96	-94	-90	-94	-96	-97	-94	-93	-92	-86	-82	-84	-86	-90	-90	-89	-83	-82	-77	-79	-85	-90	-93	-95	-99	-96	-92	-93	-94	-97	-98	-100	-97	-95	-93	-92	-95	-94	-98	-96	-97	-94	-94	-91	-89	-91	-93	-94	-93	-89	-84	-78	-70	-57	-28	18	60	91	104	109	102	70	10	-78	-176	-205	-240	-193	-145	-116	-110	-110	-113	-105	-96	-91	-86	-85	-90	-92	-91	-87	-88	-86	-84	-79	-80	-83	-87	-86	-86	-83	-81	-82	-83	-81	-83	-84	-85	-82	-77	-75	-74	-77	-82	-81	-80	-80	-75	-73	-69	-70	-72	-75	-76	-75	-72	-64	-64	-61	-60	-62	-62	-57	-54	-49	-46	-43	-42	-41	-40	-38	-37	-34	-28	-25	-27	-22	-24	-25	-26	-25	-21	-17	-20	-26	-30	-37	-42	-45	-49	-51	-55	-62	-66	-72	-78	-76	-77	-76	-76	-76	-82	-84	-91	-93	-90	-86	-85	-86	-87	-90	-91	-95	-94	-90	-88	-89	-89	-87	-90	-93	-96	-92	-89	-81	-80	-82	-88	-91	-92	-93	-85	-82	-80	-83	-81	-86	-87	-84	-80	-78	-76	-81	-86	-85	-89	-85	-82	-80	-80	-79	-78	-79	-81	-84	-88	-85	-82	-79	-77	-85	-88	-87	-89	-83	-81	-83	-86	-87	-89	-91	-91	-87	-85	-81	-82	-85	-88	-89	-87	-87	-85	-85	-87	-90	-90	-90	-90	-90	-85	-86	-83	-86	-88	-90	-92	-91	-90	-85	-81	-90	-91	-94	-95	-97	-93	-90	-85	-85	-90	-89	-93	-94	-93	-88	-82	-79	-79	-82	-88	-89	-85	-81	-75	-69	-72	-79	-87	-92	-94	-93	-90	-85	-89	-91	-97	-101	-100	-99	-96	-93	-92	-95	-97	-101	-101	-96	-96	-93	-91	-94	-96	-97	-101];
    
        % Filter design parameters
        passband = [6 40] / (app.samplingRate / 2);
        stopband = [1 45] / (app.samplingRate / 2);
        passbandRipple = 1;
        stopbandAttenuation = 40;
    
        % Get the filter order from the slider
        app.currentFilterOrder = round(app.FilterOrderSlider.Value);
    
        % Design and apply filter based on selected type
        switch app.selectedFilter
            case 'Butterworth'
                [~, Wn] = buttord(passband, stopband, passbandRipple, stopbandAttenuation);
                [b, a] = butter(app.currentFilterOrder, Wn, 'bandpass');
            case 'Chebyshev I'
                [~, Wp_cheb1] = cheb1ord(passband, stopband, passbandRipple, stopbandAttenuation);
                [b, a] = cheby1(app.currentFilterOrder, passbandRipple, Wp_cheb1, 'bandpass');
            case 'Chebyshev II'
                [~, Ws_cheb2] = cheb2ord(passband, stopband, passbandRipple, stopbandAttenuation);
                [b, a] = cheby2(app.currentFilterOrder, stopbandAttenuation, Ws_cheb2, 'bandpass');
            case 'Elliptic'
                [~, Wp_ellip] = ellipord(passband, stopband, passbandRipple, stopbandAttenuation);
                [b, a] = ellip(app.currentFilterOrder, passbandRipple, stopbandAttenuation, Wp_ellip, 'bandpass');
        end
    
        % Filter the ECG signal
        app.a_coff = a;
        app.b_coff = b;
        filteredECG = filter(b, a, app.ecgSignal);

        % Plotting in the Time Domain
        plot(app.DisplayTimeAxes, (0:length(app.ecgSignal)-1)/app.samplingRate, app.ecgSignal, 'b');
        hold(app.DisplayTimeAxes, 'on');
        plot(app.DisplayTimeAxes, (0:length(filteredECG)-1)/app.samplingRate, filteredECG, 'r');
        hold(app.DisplayTimeAxes, 'off');
        legend(app.DisplayTimeAxes, 'Original', 'Filtered');
        title(app.DisplayTimeAxes, ['ECG Signal - ' app.selectedFilter ' Filter in Time Domain']);
        xlabel(app.DisplayTimeAxes, 'Time (s)');
        ylabel(app.DisplayTimeAxes, 'Amplitude');

        % Calculate the Fourier Transform for frequency domain representation
        FFT_original = fft(app.ecgSignal);
        FFT_filtered = fft(filteredECG);
        frequencies = linspace(0, app.samplingRate/2, floor(length(app.ecgSignal)/2)+1);

        % Plotting in the Frequency Domain
        plot(app.DisplayFreqAxes, frequencies, abs(FFT_original(1:length(frequencies))), 'b');
        hold(app.DisplayFreqAxes, 'on');
        plot(app.DisplayFreqAxes, frequencies, abs(FFT_filtered(1:length(frequencies))), 'r');
        hold(app.DisplayFreqAxes, 'off');
        legend(app.DisplayFreqAxes, 'Original', 'Filtered');
        title(app.DisplayFreqAxes, ['ECG Signal - ' app.selectedFilter ' Filter in Frequency Domain']);
        xlabel(app.DisplayFreqAxes, 'Frequency (Hz)');
        ylabel(app.DisplayFreqAxes, 'Magnitude');

    end


        function onMagnitudePhaseButtonPushed(app, ~)
            % Use app.selectedFilter to get the selected filter type
            app.selectedFilter = app.selectedFilter;

            % Filter design parameters
            passband = [6 40] / (app.samplingRate / 2);
            stopband = [1 45] / (app.samplingRate / 2);
            passbandRipple = 1;
            stopbandAttenuation = 40;

            % Design filter based on selected type
            switch app.selectedFilter
                case 'Butterworth'
                    [~, Wn] = buttord(passband, stopband, passbandRipple, stopbandAttenuation);
                    [b,a] = butter(app.currentFilterOrder, Wn, 'bandpass');
                case 'Chebyshev I'
                    [~, Wp_cheb1] = cheb1ord(passband, stopband, passbandRipple, stopbandAttenuation);
                    [b,a] = cheby1(app.currentFilterOrder, passbandRipple, Wp_cheb1, 'bandpass');
                case 'Chebyshev II'
                    [~, Ws_cheb2] = cheb2ord(passband, stopband, passbandRipple, stopbandAttenuation);
                    [b,a] = cheby2(app.currentFilterOrder, stopbandAttenuation, Ws_cheb2, 'bandpass');
                case 'Elliptic'
                    [~, Wp_ellip] = ellipord(passband, stopband, passbandRipple, stopbandAttenuation);
                    [b,a] = ellip(app.currentFilterOrder, passbandRipple, stopbandAttenuation, Wp_ellip, 'bandpass');
            end
            app.b_coff = b;
            app.a_coff = a;
            % Plot the magnitude and phase response
            freqz(b,a);
            title(['Magnitude/Phase Plot - ' app.selectedFilter ' Filter']);
        end

        function onPoleZeroPlotButtonPushed(app, ~)
                zplane(app.b_coff, app.a_coff);
                title(['Pole-Zero Plot - ' app.selectedFilter ' Filter']);
        end
        
        function onSelectFilterTypeButtonPushed(app, ~)
        % Open a popup to select the type of filter
        app.selectedFilter = uiconfirm(app.MainUIFigure, 'Select Filter Type', 'Filter Type', ...
            'Options', {'Butterworth', 'Chebyshev I', 'Chebyshev II', 'Elliptic'}, ...
            'DefaultOption', 1, 'CancelOption', 4);

            if ~isempty(app.selectedFilter)
                app.selectedFilter = app.selectedFilter;
               
                onFilteredOutputButtonPushed(app);
            end
        end

    function onCoefficientsButtonPushed(app, ~)
        formattedB = sprintf('%.4f, ', app.b_coff);
        formattedB = formattedB(1:end-2); 
        formattedA = sprintf('%.4f, ', app.a_coff);
        formattedA = formattedA(1:end-2); 
        messageStr = sprintf(['Feedforward coefficients (b):\n[%s]\n\n' ...
                              'Feedback coefficients (a):\n[%s]'], ...
                              formattedB, formattedA);
        uialert(app.MainUIFigure, messageStr, 'Filter Coefficients', 'Icon', 'info');
    end


end

methods (Access = private)

    % Create MainUIFigure and components
    function createComponents(app)

        % Create MainUIFigure and hide until all components are created
        app.MainUIFigure = uifigure('Visible', 'off', 'Color', [0.8 0.9 1]);
        app.MainUIFigure.Position = [100 100 800 600];
        app.MainUIFigure.Name = 'ECG Signal Filter App';

        % Create MagnitudePhaseButton
        app.MagnitudePhaseButton = uibutton(app.MainUIFigure, 'push');
        app.MagnitudePhaseButton.ButtonPushedFcn = createCallbackFcn(app, @onMagnitudePhaseButtonPushed, true);
        app.MagnitudePhaseButton.Position = [150 550 160 22];
        app.MagnitudePhaseButton.Text = 'Display Magnitude/Phase';

        % Create PoleZeroPlotButton
        app.PoleZeroPlotButton = uibutton(app.MainUIFigure, 'push');
        app.PoleZeroPlotButton.ButtonPushedFcn = createCallbackFcn(app, @onPoleZeroPlotButtonPushed, true);
        app.PoleZeroPlotButton.Position = [350 550 160 22];
        app.PoleZeroPlotButton.Text = 'Display Pole-Zero Plot';
        app.PoleZeroPlotButton.Visible = "on";

        % Create SelectFilterTypeButton
        app.SelectFilterTypeButton = uibutton(app.MainUIFigure, 'push'); 
        app.SelectFilterTypeButton.ButtonPushedFcn = createCallbackFcn(app, @onSelectFilterTypeButtonPushed, true); 
        app.SelectFilterTypeButton.Position =  [550 550 160 22];
        app.SelectFilterTypeButton.Text = 'Select Filter Type'; 

        % Create DisplayTimeAxes
        app.DisplayTimeAxes = uiaxes(app.MainUIFigure);
        app.DisplayTimeAxes.Position = [50 50 350 400];
        app.DisplayTimeAxes.BackgroundColor = [1 1 1];

        % Create DisplayFreqAxes
        app.DisplayFreqAxes = uiaxes(app.MainUIFigure);
        app.DisplayFreqAxes.Position = [400 50 350 400];
        app.DisplayFreqAxes.BackgroundColor = [1 1 1];

        % Create FilterOrderLabel
        app.FilterOrderLabel = uilabel(app.MainUIFigure);
        app.FilterOrderLabel.Position = [100 480 240 22];
        app.FilterOrderLabel.Text = 'Filter Order: ';
        app.FilterOrderLabel.HorizontalAlignment = 'center';

        % Create FilterOrderSlider
        app.CoefficientsButton = uibutton(app.MainUIFigure);
        app.CoefficientsButton.ButtonPushedFcn = createCallbackFcn(app, @onCoefficientsButtonPushed, true); 
        app.CoefficientsButton.Position = [340 10 160 22];
        app.CoefficientsButton.Text = 'Filter Coefficients';
        app.CoefficientsButton.HorizontalAlignment = 'center';

        % Create FilterOrderSlider
        app.FilterOrderSlider = uislider(app.MainUIFigure);
        app.FilterOrderSlider.Limits = [1 20];
        app.FilterOrderSlider.Position = [300 500 300 3];
        app.FilterOrderSlider.Value = app.currentFilterOrder;
        app.FilterOrderSlider.MajorTicks = [1, 5, 10, 15, 20];
        app.FilterOrderSlider.MinorTicks = 1;
        app.FilterOrderSlider.ValueChangedFcn = @(src, event) updateFilterOrder(app, src.Value);

        app.BrandingLabel = uilabel(app.MainUIFigure);
        app.BrandingLabel.Position = [600 10 200 22];
        app.BrandingLabel.Text = 'Powered by: Hexagone and sponsored by Hamza, Maaz, Zaid, PC';
        app.BrandingLabel.HorizontalAlignment = 'center';

        % Show the figure after all components are created
        updateFilterOrder(app,app.currentFilterOrder);
        app.MainUIFigure.Visible = 'on';
    end

    function updateFilterOrder(app, value)
        onFilteredOutputButtonPushed(app);
        app.currentFilterOrder = round(value);
        app.FilterOrderLabel.Text = ['Filter Order: ' num2str(app.currentFilterOrder)];
    end
end

methods (Access = public)
    function app = project
        createComponents(app)
    end
end
end


