function [LOC, ELOC, CLOC, CCR, NCLOC, BLOC] = calcularMetricsMATLAB(nombre_archivo)
    % Abrir el archivo para lectura
    fid = fopen(nombre_archivo, 'r', 'n', 'UTF-8');
    
    if fid == -1
        error('No se pudo abrir el archivo.');
    end
    
    % Inicializar contadores
    LOC = 0;
    ELOC = 0;
    CLOC = 0;
    BLOC = 0;
    
    % Leer el archivo línea por línea
    while ~feof(fid)
        linea = fgetl(fid); % Leer una línea
        LOC = LOC + 1; % Incrementar el contador de líneas totales
        
        % Eliminar espacios en blanco al inicio y final de la línea
        linea = strtrim(linea);
        
        if isempty(linea)
            BLOC = BLOC + 1; % Contar líneas en blanco
        elseif strncmp(linea, '%', 1)  % Verificar si la línea comienza con '%'
            CLOC = CLOC + 1; % Contar líneas de comentarios
        else
            ELOC = ELOC + 1; % Contar líneas ejecutables de código
        end
    end
    
    % Cerrar el archivo
    fclose(fid);
    
    % Calcular Non-Comment Lines of Code (NCLOC)
    NCLOC = ELOC + CLOC;
    
    % Calcular Comment to Code Ratio (CCR)
    if ELOC > 0
        CCR = CLOC / ELOC;
    else
        CCR = NaN; % Evitar división por cero si no hay líneas ejecutables
    end

    % Mostrar resultados
    fprintf('Lines of Code (LOC): %d\n', LOC);
    fprintf('Executable Lines of Code (ELOC): %d\n', ELOC);
    fprintf('Comment Lines of Code (CLOC): %d\n', CLOC);
    fprintf('Comment to Code Ratio (CCR): %.2f\n', CCR);
    fprintf('Non-Comment Lines of Code (NCLOC): %d\n', NCLOC);
    fprintf('Blank Lines of Code (BLOC): %d\n', BLOC);
end