class RelationshipsController < ApplicationController

# フォローするとき
  def create
    # フォローの非同期通信する際に@userを定義した。
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    # redirect_to request.referer
  end
# フォロー外すとき
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    # redirect_to request.referer
  end
# フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
# フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
