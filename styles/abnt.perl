package main;

require "/usr/share/latex2html/styles/article.perl";

sub do_abnt_brazil {
    do_babel_portuges;
}

# capa autor anexo data local orientador citeonline titulo comentario instituicao

sub do_cmd_orientador: {
}

sub do_cmd_comentario {
}

sub do_cmd_local {
}

sub do_cmd_instituicao {
}

sub do_cmd_citeonline {
    return do_cmd_cite(@_);
}

sub do_cmd_data {
    return do_cmd_date(@_);
}

sub do_cmd_autor {
    return do_cmd_author(@_);
}

sub do_cmd_titulo {
    return do_cmd_title(@_);
}

sub do_env_citacao {
    return "<BLOCKQUOTE>".$_[0]."</BLOCKQUOTE>";
}
