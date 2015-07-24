a = [4; -1];
truefun = @(x)(nonlinfun(a,x)); % the true function

x = (0:0.1:1)';
y = truefun(x) + 0.3*randn(size(x)); % add some noise
a0 = [1; 1]; lb = []; ub = [];  % initial estimate, no lower/upper bounds

% Change some solver options
opt = optimset('lsqcurvefit');
opt = optimset(opt, ...
               'display', 'iter', ...
               'jacobian', 'on', ...
               'derivativecheck', 'on');

ahat = lsqcurvefit(@nonlinfun, a0, x, y, lb, ub, opt);

estimfun = @(x)(nonlinfun(ahat,x)); % the estimated function

% Plot the results
clf; plot(x, y, '.');
hold on; grid on
fplot(truefun, [0 1], 'r');
fplot(estimfun, [0 1], 'm');
legend('data', 'true function', 'estimated function');
