function v=rotateVector(axis, angle, vec)
    v=cos(angle)*vec+(1-cos(angle))*vec*transpose(axis)*axis+sin(angle)*cross(axis,vec);
end