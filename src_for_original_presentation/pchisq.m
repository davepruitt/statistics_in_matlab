function p = pchisq (chi2, n, ptype)
    if (ptype == 1)
        p = gammq(n, 0.5 * chi2);
    else
        p = gammp(n, 0.5 * chi2);
    end
end

function p = gammq (n, x)
    if (x < 0.5 * n + 1)
        p = 1 - gser(n, x);
    else
        p = gcf_chi2(n, x);
    end
end

function p = gammp (n, x)
    if (x < 0.5 * n + 1)
        p = gser(n, x);
    else
        p = 1 - gcf_chi2(n, x);
    end
end

function p = gcf_chi2 (n, x)
    eps = 1e-6;
    gln = gamnln(n);

    a = 0.5*n;
    b = x+1-a;
    fpmin = 1.e-300;
    c = 1/fpmin;
    d = 1/b;
    h=d;
    for i=1:100
        an = -i * (i-a);
        b = b + 2;
        d = an*d + b;
        if (abs(d) < fpmin) 
            d = fpmin;
        end
        c = b + an/c;
        if (abs(c) < fpmin)
            c = fpmin;
        end
        d = 1/d;
        del = d*c;
        h = h*del;
        if (abs(del-1) < eps)
            break;
        end
    end
    
    p = h * exp(-x + a*log(x) - gln);
end

function p = gamnln ( n )

    if (n < 201)
        p = gammaln(n / 2);
    else
        coef = [76.18009172947146, -86.50532032941677, 24.01409824083091, -1.231739572450155, 1.208650973866179e-3, -5.395239384953e-6];
        stp = 2.5066282746310005;
        x = 0.5*n;
        y = x;
        tmp = x + 5.5;
        tmp = (x+0.5)*Math.log(tmp) - tmp;
        ser = 1.000000000190015; 
        for i=1:6
            y = y + 1;
            ser = ser + coef(i) / y;
            gamln = tmp + Math.log(stp*ser/x);
            p = gamln;
        end
    end

end

function p = gser(n,x)
    eps = 1.e-6;
    gln = gamnln(n);
    a = 0.5*n;
    ap = a;
    sum = 1.0/a;
    del = sum;
    for n=1:100
        ap = ap + 1;
        del = del *x / ap;
        sum = sum + del;
        if (del < sum*eps)
            break;
        end
    end
    p = sum * exp(-x + a*log(x) - gln);
 end













