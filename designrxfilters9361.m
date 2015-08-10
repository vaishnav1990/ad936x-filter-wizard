% Inputs
% ============================================
% Fout       = Output sample data rate (in Hz)
% FIR_interp = FIR decimation factor
% HB_interp  = half band filters decimation factor
% PLL_mult   = PLL multiplication
% Fpass      = passband frequency (in Hz)
% Fstop      = stopband frequency (in Hz)
% dBripple   = max ripple allowed in passband (in dB)
% dBstop     = min attenuation in stopband (in dB)
% dBstop_FIR = min rejection that TFIR is required to have (in dB)
% phEQ       = Phase Equalization on (not -1)/off (-1)
% int_FIR    = Use AD9361 FIR on (1)/off (0)
% wnom       = analog cutoff frequency (in Hz)
%
% Outputs
%===============================================
% rfirtaps         = fixed point coefficients for AD9361
% rxFilters        = system object for visualization
%
function result = designrxfilters9361(input)

wnom = 1.4 * input.Fstop;
div = ceil((input.clkPLL/wnom)*(log(2)/(2*pi)));
input.caldiv = min(max(div,1),511);

result = internal_designrxfilters9361_sinc(input);
