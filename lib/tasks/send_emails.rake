namespace :send_emails do

  desc "이메일 보내기 자동화 테스트"
  task test: :environment do
    print("Hello world")
    UserMailer.welcome_email("geniuslim27@gmail.com",
                             "geniuslim27@likelion.org",
                             "제목",
                             "내용").deliver_now

  end

  desc "이메일 보내기"
  task sends: :environment do
    if ENV["PROPOSE_ID"] == nil
      print("Argument 설정 필수")
      return
    end


  end
end
