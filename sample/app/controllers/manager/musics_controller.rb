class Manager::MusicsController < ApplicationController
  def index
    @page_name = "manager_musics"
    manager_musics = Music.all.map do |manager_music|
      DataFormer.new(manager_music)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end

    @component_data = {
      manager_musics: manager_musics,
      create_url: manager_musics_path
    }

    render "/react/page"
  end

  def create
    manager_music = Music.new manager_music_params

    save_model(manager_music, "manager_music") do |_manager_music|
      DataFormer.new(_manager_music)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end
  end

  def update
    manager_music = Music.find(params[:id])

    update_model(manager_music, manager_music_params, "manager_music") do |_manager_music|
      DataFormer.new(_manager_music)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end
  end

  def destroy
    manager_music = Music.find(params[:id])
    manager_music.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def manager_music_params
      params.require(:manager_music).permit(:name, :views)
    end
end
