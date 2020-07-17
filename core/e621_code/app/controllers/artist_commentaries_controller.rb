class ArtistCommentariesController < ApplicationController
  respond_to :html, :json, :js
  before_action :admin_only

  def index
    @commentaries = ArtistCommentary.search(search_params).paginate(params[:page], :limit => params[:limit])
    respond_with(@commentaries)
  end

  def show
    if params[:id]
      @commentary = ArtistCommentary.find(params[:id])
    else
      @commentary = ArtistCommentary.find_by_post_id!(params[:post_id])
    end

    respond_with(@commentary) do |format|
      format.html { redirect_to post_path(@commentary.post) }
    end
  end

  def create_or_update
    @artist_commentary = ArtistCommentary.find_or_initialize_by(post_id: params.dig(:artist_commentary, :post_id))
    @artist_commentary.update(commentary_params)
    respond_with(@artist_commentary)
  end

  def revert
    @artist_commentary = ArtistCommentary.find_by_post_id!(params[:id])
    @version = @artist_commentary.versions.find(params[:version_id])
    @artist_commentary.revert_to!(@version)
  end

private

  def commentary_params
    params.fetch(:artist_commentary, {}).except(:post_id).permit(%i[
      original_description original_title translated_description translated_title
    ])
  end
end
