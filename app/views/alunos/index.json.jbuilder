json.array!(@alunos) do |aluno|
  json.extract! aluno, :id, :nome, :serie, :turma, :endereco, :nota1, :nota2, :nota3, :nota4
  json.url aluno_url(aluno, format: :json)
end
