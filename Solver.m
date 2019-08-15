classdef Solver < matlab.mixin.Copyable
    properties
        ForceStop
        Stop
    end
    properties(SetAccess = private)

    end
    methods
        function obj=Solver

        end

        function StartInteractive(obj)
            % initialize
            obj.Stop=0; 
            disp('started')
            i=0;
            while ~obj.Stop
                if mod(i,1)==0
                    notify(obj,'IterationDone');
                end
                i=i+1;
            end
            disp('stopped')
        end
        function StopInteractive(obj)
            obj.Stop=1;
        end
        
        function x = Check(obj)
            %%whatever you want to check and send to the base workspace
            %assignin('base', 'x', x);
        end
        function stop = OnIteration(obj,varargin)
            % This is method is useful when using Matlab's own solvers like
            % fmincon etc. to show intermiedate results.
            persistent iter
            if isempty(iter)
                iter=1;
            end
            if obj.ForceStop
                stop = true;
                obj.ForceStop=false;
            else
                stop = false;
            end
            if iter==1
                notify(obj,'IterationDone');
                iter=1;
            else
                iter=iter+1;
            end
        end
    end
    events
        IterationDone
    end
end

