class AttendanceMailer < ApplicationMailer
  default from: 'asseorteg@gmail.com'
 
  def admin_email(administrator)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @administrator = administrator

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @administrator.email, subject: 'Un nouveau participant à votre event !') 
  end
end
