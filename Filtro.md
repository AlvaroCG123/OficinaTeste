//procurar
SELECT 
    c.nome AS Cliente,
    c.documento AS CPF_CNPJ,
    v.placa AS Placa_Veiculo,
    v.modelo AS Modelo_Veiculo,
    os.numero_os AS Numero_OS,
    os.abertura AS Data_Abertura,
    os.etapa AS Status_OS,
    os.observacao
FROM cliente c
JOIN veiculo v ON c.id = v.clienteId
JOIN ordem_servico os ON v.id = os.veiculoId
WHERE c.nome LIKE '%Nome do Cliente%'; -- Substitua pelo nome do cliente que você quer buscar

//deletar
Delete 
    c.nome AS Cliente,
    c.documento AS CPF_CNPJ,
    v.placa AS Placa_Veiculo,
    v.modelo AS Modelo_Veiculo,
    os.numero_os AS Numero_OS,
    os.abertura AS Data_Abertura,
    os.etapa AS Status_OS,
    os.observacao
FROM cliente c
JOIN veiculo v ON c.id = v.clienteId
JOIN ordem_servico os ON v.id = os.veiculoId
WHERE c.nome LIKE '%Maria%';