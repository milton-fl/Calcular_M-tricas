% Solicitar al usuario que ingrese el nombre del archivo de entrada
nombre_archivo_entrada = input('Ingrese el nombre del archivo CSV (): ', 's');

% Leer los datos desde el archivo de entrada
try
    tabla = readtable(nombre_archivo_entrada);
    disp('Datos cargados correctamente.');
    
    % Mostrar las primeras 10 filas de la tabla
    disp('Primeras 10 filas del archivo CSV:');
    disp(tabla(1:min(10, height(tabla)), :));
    
    % Identificar las columnas numéricas
    numericData = varfun(@isnumeric, tabla, 'OutputFormat', 'uniform');
    
    % Preparar una estructura para almacenar las estadísticas
    stats = struct('Variable', {}, 'Media', {}, 'Moda', {}, 'Mediana', {}, ...
                   'Varianza', {}, 'DesviacionEstandar', {}, 'Rango', {}, ...
                   'Suma', {}, 'TamanoMuestra', {}, 'Minimo', {}, 'Maximo', {}, ...
                   'Cuartil1', {}, 'Cuartil3', {}, 'IQR', {});

    % Calcular estadísticas descriptivas solo para columnas numéricas
    for i = 1:width(tabla)
        if numericData(i)
            datos = tabla{:, i};
            media = mean(datos);
            moda = mode(datos);
            mediana = median(datos);
            varianza = var(datos);
            desviacion_estandar = std(datos);
            rango = range(datos);
            suma = sum(datos);
            tamano_muestra = length(datos);
            minimo = min(datos);
            maximo = max(datos);
            cuartil_1 = quantile(datos, 0.25);
            cuartil_3 = quantile(datos, 0.75);
            IQR = cuartil_3 - cuartil_1;

            % Guardar las estadísticas en la estructura
            stats(i).Variable = tabla.Properties.VariableNames{i};
            stats(i).Media = media;
            stats(i).Moda = moda;
            stats(i).Mediana = mediana;
            stats(i).Varianza = varianza;
            stats(i).DesviacionEstandar = desviacion_estandar;
            stats(i).Rango = rango;
            stats(i).Suma = suma;
            stats(i).TamanoMuestra = tamano_muestra;
            stats(i).Minimo = minimo;
            stats(i).Maximo = maximo;
            stats(i).Cuartil1 = cuartil_1;
            stats(i).Cuartil3 = cuartil_3;
            stats(i).IQR = IQR;
        end
    end
    
    % Mostrar las estadísticas descriptivas en formato vertical
    fprintf('Estadísticas descriptivas de las columnas numéricas:\n');
    
    % Mostrar las variables como encabezados de columna en horizontal
    fprintf('%-20s', ' ');
    for i = 1:length(stats)
        fprintf('%-20s', stats(i).Variable);
    end
    fprintf('\n');
    
    % Mostrar las estadísticas en formato vertical
    campos = fieldnames(stats);
    for j = 1:length(campos)
        fprintf('%-20s', campos{j});
        for i = 1:length(stats)
            fprintf('%-20.2f', stats(i).(campos{j}));
        end
        fprintf('\n');
    end
    
catch ME
    disp(['Error al cargar el archivo CSV: ', ME.message]);
end
