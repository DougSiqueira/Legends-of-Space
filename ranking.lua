function LoadScore(filename, filename2, n) 
  local file = io.open(filename,"r")
  local file2 = io.open(filename2, "r")

  for i=0, n, 1 do

    score[i] = file:read("*n")
    nomes[i] = file2:read("*l")
  end
  file:close()
  file2:close()
end

function inserirNoRank()

  table.insert(score, pontos)
  table.insert(nomes, play)

--ordenando
  for i=0, 4, 1 do
    for j=i, 4, 1 do
      if(score[j]>aux) then
        aux = score[j]
        auxName = nomes[j]
        k = j
      end
    end

    score[k] = score[i]
    nomes[k] = nomes[i]
    score[i] = aux
    nomes[i] = auxName
    aux = -1
  end 
  -- Abrindo arquivos pra escrita
  file = io.open("score.txt", "w")
  file2 = io.open("nomes.txt", "w")

  --Inserindo
  for i = 0, 4, 1 do
    file:write(score[i].."\n")
    file2:write(nomes[i].."\n")
  end
  
  --Salvando em texto
  file:flush()
  file2:flush()
  file:close()
  file2:close()
end

