function [Answer] = decision(A, B, C)
    discrs = discriminant(A,B,C);
    [~, qun] = size(A);
    Answer = strings(1, qun);
    for i = 1 : qun
        if (A(1, i) == 0) 
            if (B(1, i) == 0)
                if (C(1, i) == 0)
                Answer(1, i) = "Бесконечное количество решений";
            else 
                Answer(1, i) = "Уравнение не имеет решений";
                end
            else 
                Answer(1, i) = "Уравнение имеет единственное решение x = " + (-C(1, i) / B(1, i));
            end
        else if (discrs(1, i) < 0)
                Answer(1, i) = "Решение уравнения выражается в комплексных числах";
            else if (discrs(1, i) == 0)
                Answer(1, i) = "Уравнение имеет единственное решение x = " + (- B(i))/ (2 * A(i));
            else
                x1 = round((-B(1, i) + sqrt(discrs(1, i)))/(2 * A(1, i)), 5);
                x2 = round((-B(1, i) - sqrt(discrs(1, i)))/(2 * A(1, i)), 5);
                Answer(1, i) = "Решение уравнения: х1 = " + x1 + ", x2 = " + x2;
                end
            end
        end
    end
end

function  [discrs] = discriminant(a, b, c)
    discrs = b .* b - 4 * a .* c;
end
