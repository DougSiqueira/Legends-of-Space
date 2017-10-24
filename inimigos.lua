--Criar naves inimigas
function inimigo(dt)
  tempoCriarInimigo = tempoCriarInimigo - (1 * dt)
  if tempoCriarInimigo < 0 then
    tempoCriarInimigo = delayInimigo
    if nivelInimigos == 4 then 
      for numeroAleatorio = 20, love.graphics.getWidth(),  imgInimigo:getWidth() + 10 do  --posição alinhada
        novoInimigo = {x = numeroAleatorio, y = - imgInimigo:getWidth(), img = imgInimigo} -- posição aleatoria
        table.insert(inimigos, novoInimigo)
      end
    end
     if nivelInimigos >= 5 then 
        imgInimigo = imgInimigo2
      for numeroAleatorio = 20, love.graphics.getWidth(),  imgInimigo2:getWidth() + 10 do  --posição alinhada
        novoInimigo = {x = numeroAleatorio, y = - imgInimigo:getWidth(), img = imgInimigo} -- posição aleatoria
        table.insert(inimigos, novoInimigo)
      end

    else
      numeroAleatorio = math.random(20, love.graphics.getWidth() - ((imgInimigo:getWidth()/2) + 20)) --posiçao randomica
      novoInimigo = {x = numeroAleatorio, y = - imgInimigo:getWidth(), img = imgInimigo} -- posição aleatoria
      table.insert(inimigos, novoInimigo)
    end
  end

  for j, inimigo in ipairs(inimigos) do
    inimigo.y = inimigo.y + (velocidadeInimigo * dt)
    if inimigo.y > 850 then
      table.remove(inimigos, j)   
      if pontos > 0 then
        pontos = pontos - 1  
      end
    end
  end
end



-- Criar astedoides
function asteroide(dt)
  tempoAteCair = tempoAteCair - (1 * dt)
  if tempoAteCair < 0 then
    tempoAteCair = delayAsteroide
    novoAsteroide = {x = nave.posX - imgNave:getWidth()/2, y = - imgAsteroide[ast]:getWidth(), img = imgAsteroide[ast]}
    table.insert(asteroides, novoAsteroide)
  end
  for i, asteroide in ipairs(asteroides) do
    asteroide.y = asteroide.y + (velocidadeAsteroide * dt)
    if asteroide.y > 850 then
      table.remove(asteroides, i)      
    end
  end
end


-- Criar upTiro
function upTiro(dt)
  if tiroLvl <2 then
    tempoCairUp = tempoCairUp - (1 * dt)
    if tempoCairUp < 0 then
      tempoCairUp = delayUpTiro
       numeroAleatorio1 = math.random(20, love.graphics.getWidth() - 20) --posiçao randomica
      novoUpTiro = {x = numeroAleatorio1, y = - imgUpTiro:getWidth(), img = imgUpTiro}
      table.insert(upTiros, novoUpTiro)
    end
    for i, upTiro in ipairs(upTiros) do
      upTiro.y = upTiro.y + (velocidadeUpTiro * dt)
      if upTiro.y > 850 then
        table.remove(upTiros, i)      
      end
    end
  end
end

