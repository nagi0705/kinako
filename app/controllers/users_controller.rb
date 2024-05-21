class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_user, only: [:show, :edit, :update]

  def show
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    # @userはset_userメソッドによって設定されています
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールが更新されました。"
    else
      render :edit, alert: "プロフィールの更新に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path, alert: "指定されたユーザーが見つかりません。" if @user.nil?
  end

  def check_user
    redirect_to post_images_path, alert: "アクセス権限がありません。" if @user.id != current_user.id
  end
end
