class ContactMailer < ApplicationMailer
  def send_mail(mail_title,mail_content,group_users,group) #メソッドに対して引数を設定
  # メールの内容を作成している
    @group = group
    @mail_title = mail_title
    @mail_content = mail_content
    # 送信する対象（メールアドレス）とタイトル名
    mail bcc: group_users.pluck(:email), subject: mail_title
  end
end
