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
    
    % Leer el archivo l�nea por l�nea
    while ~feof(fid)
        linea = fgetl(fid); % Leer una l�nea
        LOC = LOC + 1; % Incrementar el contador de l�neas totales
        
        % Eliminar espacios en blanco al inicio y final de la l�nea
        linea = strtrim(linea);
        
        if isempty(linea)
            BLOC = BLOC + 1; % Contar l�neas en blanco
        elseif strncmp(linea, '%', 1)  % Verificar si la l�nea comienza con '%'
            CLOC = CLOC + 1; % Contar l�neas de comentarios
        else
            ELOC = ELOC + 1; % Contar l�neas ejecutables de c�digo
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
        CCR = NaN; % Evitar divisi�n por cero si no hay l�neas ejecutables
    end

    % Mostrar resultados
    fprintf('Lines of Code (LOC): %d\n', LOC);
    fprintf('Executable Lines of Code (ELOC): %d\n', ELOC);
    fprintf('Comment Lines of Code (CLOC): %d\n', CLOC);
    fprintf('Comment to Code Ratio (CCR): %.2f\n', CCR);
    fprintf('Non-Comment Lines of Code (NCLOC): %d\n', NCLOC);
    fprintf('Blank Lines of Code (BLOC): %d\n', BLOC);
end