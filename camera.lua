
-- Mover continuamente a camera(backGround)
function camera(dt)
  planoDeFundo.y = planoDeFundo.y + (planoDeFundo.velocidade * dt)
  planoDeFundo.y2 = planoDeFundo.y2 + (planoDeFundo.velocidade * dt)

  if planoDeFundo.y > alturaTela then
    planoDeFundo.y = planoDeFundo.y2 - imgFundo2:getHeight()
  end
  if planoDeFundo.y2> alturaTela then
    planoDeFundo.y2  = planoDeFundo.y - imgFundo:getHeight()
  end

end

-- Animaçao asteroide
function anintime(n, dt) -- n o tamanho do vetor das animações 
  time = time + dt
  if time > 0.04 then
    if ast < n then
      ast = ast+ 1
    else
      ast = 0
    end
    time = 0

  end
end

-- Animaçao explosão
function aninExplosao(n, dt) -- n o tamanho do vetor das animações 
  for i, _ in ipairs(expInimigo) do
    expInimigo[i].intervaloAnim = expInimigo[i].intervaloAnim + dt
    if expInimigo[i].intervaloAnim > 0.01 then
      expInimigo[i].intervaloAnim = 0
      if expInimigo[i].aExp < n then
        expInimigo[i].aExp = expInimigo[i].aExp + 1
      else
        table.remove(expInimigo, i)
      end
    end
  end
end

-- Iniciar jogo
function iniciarJogo(dt)
  if abreTela and not estavivo then
    dX = dX + 600 * dt
    if dX > 481 then
      dY = -700
      dX = 0
      estavivo = true
    end
  elseif not abreTela then
    estavivo = false
    dY = dY + 600 * dt
    if dY > 0 then
      dY = 0
    end
  end
end


--Apresentação do jogo
function Apresentando(dt)
  apresentacao.y = apresentacao.y - (apresentacao.velocidade * dt)
  if apresentacao.y <= - imgApresentacao:getHeight() then
    somApresentacao:stop()
    apresentando = false
    menu = true
  end
end


