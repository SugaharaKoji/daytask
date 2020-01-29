class TaskMailer < ApplicationMailer
  default from: 'daytask@example.com' #常に同じ送信者

  def creation_email(task)
    @task =task
    mail(
      subject: 'タスク作成完了メール'
      to: 'user@example.com'
    　 from: 'daytask@example.com' 
    )
  end
end
