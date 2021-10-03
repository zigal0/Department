function bitsValue = makeCircle(numberOfPoints)
    if numberOfPoints == 2
        edgeCur = 0;
    else
        edgeCur = pi / numberOfPoints;
    end
    edgeStep = 2 * pi / numberOfPoints;
    bitsValue = zeros(numberOfPoints, 1);
    for k = 1:1:numberOfPoints
        bitsValue(k, 1) = cos(edgeCur) + 1j * sin(edgeCur);
        edgeCur = edgeCur + edgeStep;
    end
end