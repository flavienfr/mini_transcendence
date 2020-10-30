# 1 une guilde demande à faire la guerre à une autre:
# - req POST /ask_for_wars pour sauvegarder la demande dans un objet

# 2 attendre que la guilde accepte la demande de guerre
# - on pourrait attendre que le meneur fasse clique gauche sur une notification adressée à la guilde
    # 3 si acceptation:
    # - req POST /wars pour sauvegarder l'objet war avec les 2 guild ids (passer l'id de l'objet ask_for_war à la req)
    # - en même temps on créer les 2 objets war_participation (dans la même méthode: war/create)

# - sinon si refus rien ne se passe ?

-------------

ask_for_war:status = "pending" / "accepted" / "denied"



-------------


@joignable_groups = Channel.where("scope = ? OR scope = ?", "public-group", "protected-group");
puts @joignable_groups.to_json;
@channel_participations = User.find_by(id: current_user.id).channel_participations;
puts "HERE"
puts @channel_participations.to_json;
@joignable_groups = @joignable_groups.where("id NOT IN (?)", @channel_participations.pluck(:channel_id));
@joignable_groups = @joignable_groups.find_all_by_id(@channel_participations.pluck(:channel_id));

Product.where('id NOT IN (?)', [2,3,4,5,6])
@joignable_groups = @joignable_groups.find_all_by_id("id: ?", @channel_participations.pluck(:channel_id));
Comment.where.not(id: [2, 3, 5])
Comment.find_all_by_id([2, 3, 5])


if (current_user)
    @users = User.all
    puts "------------a-----------"
    @joignable_groups = Channel.where("scope = ? OR scope = ?", "public-group", "protected-group");
    puts @joignable_groups.to_json;
    @channel_participations = User.find_by(id: current_user.id).channel_participations;
    puts "HERE"
    puts @channel_participations.to_json;
    if (@channel_participations.pluck(:channel_id).size > 0)
      @joignable_groups = @joignable_groups.where.not("id IN (?)", @channel_participations.pluck(:channel_id));
    end
    #@joignable_groups = joignable_groups2.size > 0 ? joignable_groups2 : @joignable_groups;
    #puts "HERE2"
    puts @joignable_groups.to_json;#a utiliser
    @private_channels = Channel.where("scope = ?", "private-direct");
    puts @private_channels.to_json;
    @channel_participations = @channel_participations.where.not("channel_id IN (?)", @private_channels.pluck(:id));
    puts @channel_participations.to_json;
    @in_channels = Channel.where("id IN (?)", @channel_participations.pluck(:channel_id));
    puts @in_channels.to_json;#a utiliser
    puts "---------b---------"
  end