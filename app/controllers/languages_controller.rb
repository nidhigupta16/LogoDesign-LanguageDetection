class LanguagesController < ApplicationController
  before_action :authorize_request 

  def index
    render json: Language.all, each_serializer: LanguageSerializer
  end

  def current_language
    language = @current_user.userlanguage ? @current_user.userlanguage.language : Language.find_or_create_by(name: "English")
    render json: language, single_serializer: LanguageSerializer
  end

  def update_current_language
    begin
      @current_user.userlanguage.present? ? @current_user.userlanguage.update(language_params) : @current_user.create_userlanguage(language_params)
      render json: { message: "Language updated successfully", language: @current_user.userlanguage.language }
    rescue
      render json: {message: "Some error occured!"}, status: :unprocessable_entity
    end
  end

  private
  def language_params
    params.permit(:language_id)
  end
end
