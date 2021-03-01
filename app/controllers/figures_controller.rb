class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      figure.titles.create(params[:title])
    end
    if !params[:landmark][:name].empty?
      figure.landmarks.create(params[:landmark])
    end
    redirect '/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure_titles = @figure.titles
    @figure_landmarks = @figure.landmarks
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find_by_id(params[:id])
    figure.update(params[:figure])
    if !params[:title][:name].empty?
      figure.titles.create(params[:title])
    end
    if !params[:landmark][:name].empty?
      figure.landmarks.create(params[:landmark])
    end
    redirect "/figures/#{figure.id}"
  end

end
