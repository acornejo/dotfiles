if !exists('g:plugs') || !has_key(g:plugs, 'vim-abolish')
  finish
endif

function! s:ConfigAbolish()
  if !exists(':Abolish')
    return
  endif
  " our -> or
  Abolish {col,behavi,fav,flav,hon,neighb,rum,lab}our{,s,ed,less,able,ing} {}or{}

  " re -> er
  Abolish {cent,met,kilomet,lit,lust,mit,nit,goit,reconnoit,saltpet,spect,theat,tit}re{,s} {}er{}

  " ce -> se
  Abolish {defen,offen,preten}ce {}se

  " is -> iz
  Abolish {actual,aggrand,agon,alphabet,antagon,anthropomorph,aphor,apolog,arbor,author,autom,bapt,barbar,brutal,canon,capital,categor,cauter,character,civil,colon,color,compartmental,computer,conceptual,concret,criminal,critic,crystal,custom,demonet,departmental,desensit,destabil,digital,dogmat,dramat,econom,emphas,energ,eulog,euthan,extempor,external,factual,fantas,fertil,fibern,final,formal,fratern,galvan,general,global,harmon,hellen,homogen,hospital,human,hypothes,ideal,immobil,individual,institutional,internal,ion,legal,legitim,lion,material,memor,mesmer,method,moral,motor,national,natural,neutral,normal,notar,organ,ostrac,pagan,pasteur,patron,penal,personal,philosoph,plagiar,polar,popular,pressur,priorit,privat,proselyt,public,pulver,quant,random,rational,real,recogn,regional,satir,sensual,serial,social,special,stabil,standard,steril,stigmat,subsid,summar,symbol,synchron,synthes,terror,theor,total,tranquil,trivial,tyrann,universal,urban,util,vandal,vapor,vasectom,visual,vocal,weather,woman}is{e,ed,er,es,ation} {}iz{}

  " ys -> yz
  Abolish {anal,catal,hydrol,paral}ys{e,ed} {}yz{}

  " single words
  Abolish jewellery jewelry
  Abolish fulfil fulfill
  Abolish judgement judgment
  Abolish sceptic{,al,ism} skeptic{,al,ism}
endfunction

au VimEnter * call s:ConfigAbolish()
