$PBExportHeader$w_agenda.srw
forward
global type w_agenda from window
end type
type st_1 from statictext within w_agenda
end type
type cb_cerrar from commandbutton within w_agenda
end type
type cb_abrir from commandbutton within w_agenda
end type
type hsb_2 from hscrollbar within w_agenda
end type
type p_10 from picture within w_agenda
end type
type p_9 from picture within w_agenda
end type
type p_8 from picture within w_agenda
end type
type p_7 from picture within w_agenda
end type
type p_6 from picture within w_agenda
end type
type p_5 from picture within w_agenda
end type
type p_4 from picture within w_agenda
end type
type p_3 from picture within w_agenda
end type
type p_2 from picture within w_agenda
end type
type p_1 from picture within w_agenda
end type
type hsb_1 from hscrollbar within w_agenda
end type
type dw_1 from datawindow within w_agenda
end type
type gb_2 from groupbox within w_agenda
end type
type gb_3 from groupbox within w_agenda
end type
type p_11 from picture within w_agenda
end type
type p_13 from picture within w_agenda
end type
type p_12 from picture within w_agenda
end type
type dw_2 from datawindow within w_agenda
end type
type tab_1 from tab within w_agenda
end type
type tabpage_a from userobject within tab_1
end type
type tabpage_a from userobject within tab_1
end type
type tabpage_c from userobject within tab_1
end type
type tabpage_c from userobject within tab_1
end type
type tabpage_e from userobject within tab_1
end type
type tabpage_e from userobject within tab_1
end type
type tabpage_g from userobject within tab_1
end type
type tabpage_g from userobject within tab_1
end type
type tabpage_i from userobject within tab_1
end type
type tabpage_i from userobject within tab_1
end type
type tabpage_k from userobject within tab_1
end type
type tabpage_k from userobject within tab_1
end type
type tabpage_m from userobject within tab_1
end type
type tabpage_m from userobject within tab_1
end type
type tabpage_ny from userobject within tab_1
end type
type tabpage_ny from userobject within tab_1
end type
type tabpage_p from userobject within tab_1
end type
type tabpage_p from userobject within tab_1
end type
type tabpage_r from userobject within tab_1
end type
type tabpage_r from userobject within tab_1
end type
type tabpage_t from userobject within tab_1
end type
type tabpage_t from userobject within tab_1
end type
type tabpage_v from userobject within tab_1
end type
type tabpage_v from userobject within tab_1
end type
type tabpage_x from userobject within tab_1
end type
type tabpage_x from userobject within tab_1
end type
type tabpage_z from userobject within tab_1
end type
type tabpage_z from userobject within tab_1
end type
type tab_1 from tab within w_agenda
tabpage_a tabpage_a
tabpage_c tabpage_c
tabpage_e tabpage_e
tabpage_g tabpage_g
tabpage_i tabpage_i
tabpage_k tabpage_k
tabpage_m tabpage_m
tabpage_ny tabpage_ny
tabpage_p tabpage_p
tabpage_r tabpage_r
tabpage_t tabpage_t
tabpage_v tabpage_v
tabpage_x tabpage_x
tabpage_z tabpage_z
end type
end forward

global type w_agenda from window
integer x = 78
integer y = 80
integer width = 3502
integer height = 2116
boolean titlebar = true
string title = "Agenda"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
st_1 st_1
cb_cerrar cb_cerrar
cb_abrir cb_abrir
hsb_2 hsb_2
p_10 p_10
p_9 p_9
p_8 p_8
p_7 p_7
p_6 p_6
p_5 p_5
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
hsb_1 hsb_1
dw_1 dw_1
gb_2 gb_2
gb_3 gb_3
p_11 p_11
p_13 p_13
p_12 p_12
dw_2 dw_2
tab_1 tab_1
end type
global w_agenda w_agenda

type variables
Long id_ventana_activa
end variables

on w_agenda.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_1=create st_1
this.cb_cerrar=create cb_cerrar
this.cb_abrir=create cb_abrir
this.hsb_2=create hsb_2
this.p_10=create p_10
this.p_9=create p_9
this.p_8=create p_8
this.p_7=create p_7
this.p_6=create p_6
this.p_5=create p_5
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.hsb_1=create hsb_1
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.p_11=create p_11
this.p_13=create p_13
this.p_12=create p_12
this.dw_2=create dw_2
this.tab_1=create tab_1
this.Control[]={this.st_1,&
this.cb_cerrar,&
this.cb_abrir,&
this.hsb_2,&
this.p_10,&
this.p_9,&
this.p_8,&
this.p_7,&
this.p_6,&
this.p_5,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.hsb_1,&
this.dw_1,&
this.gb_2,&
this.gb_3,&
this.p_11,&
this.p_13,&
this.p_12,&
this.dw_2,&
this.tab_1}
end on

on w_agenda.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_cerrar)
destroy(this.cb_abrir)
destroy(this.hsb_2)
destroy(this.p_10)
destroy(this.p_9)
destroy(this.p_8)
destroy(this.p_7)
destroy(this.p_6)
destroy(this.p_5)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.hsb_1)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.p_11)
destroy(this.p_13)
destroy(this.p_12)
destroy(this.dw_2)
destroy(this.tab_1)
end on

event open;X=0
Y=0
dw_1.settransObject(sqlca)
dw_2.settransObject(sqlca)
dw_1.visible=false
dw_2.visible=false
tab_1.visible=false
p_1.visible=false
p_2.visible=false
p_3.visible=false
p_4.visible=false
p_5.visible=false
p_6.visible=false
p_7.visible=false
p_8.visible=false
p_9.visible=false
p_10.visible=false
p_12.visible=false
p_13.visible=false
hsb_1.visible=false
hsb_2.visible=false
end event

event close;f_menu_cerrar_ventana(this, id_ventana_activa)
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

end event

type st_1 from statictext within w_agenda
integer x = 3122
integer y = 160
integer width = 165
integer height = 1124
integer textsize = -28
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "A G E N D A"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cerrar from commandbutton within w_agenda
integer x = 3049
integer y = 1424
integer width = 297
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;if p_11.visible=false then
	dw_1.visible=false
	dw_2.visible=false
	tab_1.visible=false
	p_1.visible=false
	p_2.visible=false
	p_3.visible=false
	p_4.visible=false
	p_5.visible=false
	p_6.visible=false
	p_7.visible=false
	p_8.visible=false
	p_9.visible=false
	p_10.visible=false
	p_12.visible=false
	p_13.visible=false
	hsb_1.visible=false
	hsb_2.visible=false
	p_11.visible=true
else
	close(parent)
end if
end event

type cb_abrir from commandbutton within w_agenda
integer x = 3049
integer y = 1336
integer width = 297
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Abrir"
end type

event clicked;tab_1.visible=true
dw_1.visible=true
dw_2.visible=true
p_1.visible=true
p_2.visible=true
p_3.visible=true
p_4.visible=true
p_5.visible=true
p_6.visible=true
p_7.visible=true
p_8.visible=true
p_9.visible=true
p_10.visible=true
p_12.visible=true
p_13.visible=true
hsb_1.visible=true
hsb_2.visible=true
p_11.visible=false
end event

type hsb_2 from hscrollbar within w_agenda
integer x = 1614
integer y = 1732
integer width = 142
integer height = 52
boolean bringtotop = true
end type

event lineleft;dw_2.ScrollPriorPage() 
end event

event lineright;dw_2.ScrollNextPage() 
end event

type p_10 from picture within w_agenda
integer x = 1458
integer y = 1356
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_9 from picture within w_agenda
integer x = 1458
integer y = 1224
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_8 from picture within w_agenda
integer x = 1458
integer y = 1092
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_7 from picture within w_agenda
integer x = 1458
integer y = 960
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_6 from picture within w_agenda
integer x = 1458
integer y = 828
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_5 from picture within w_agenda
integer x = 1458
integer y = 696
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_4 from picture within w_agenda
integer x = 1458
integer y = 564
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_3 from picture within w_agenda
integer x = 1458
integer y = 432
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_agenda
integer x = 1458
integer y = 300
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_agenda
integer x = 1458
integer y = 168
integer width = 142
integer height = 132
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type hsb_1 from hscrollbar within w_agenda
integer x = 1303
integer y = 1732
integer width = 142
integer height = 52
boolean bringtotop = true
end type

event lineleft;dw_1.ScrollPriorPage() 

end event

event lineright;dw_1.ScrollNextPage() 
end event

type dw_1 from datawindow within w_agenda
integer x = 233
integer y = 156
integer width = 1262
integer height = 1648
integer taborder = 40
string dataobject = "dw_agenda"
boolean livescroll = true
end type

event doubleclicked;if isnull(row) then return
if row=0 then return

beep(1)
str_parametros lstr_param

lstr_param.i_nargumentos=2

lstr_param.s_argumentos[2]=getitemstring(row,"codigo")

OpenWithParm(wi_mant_clientes2,lstr_param)  

end event

type gb_2 from groupbox within w_agenda
integer x = 3031
integer y = 92
integer width = 334
integer height = 1224
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type gb_3 from groupbox within w_agenda
integer x = 3031
integer y = 1292
integer width = 334
integer height = 232
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type p_11 from picture within w_agenda
integer x = 1486
integer y = 124
integer width = 1239
integer height = 1352
string picturename = "c:\bmp\portada.bmp"
boolean focusrectangle = false
end type

type p_13 from picture within w_agenda
integer x = 1458
integer y = 1616
integer width = 142
integer height = 132
boolean bringtotop = true
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type p_12 from picture within w_agenda
integer x = 1458
integer y = 1484
integer width = 142
integer height = 132
boolean bringtotop = true
string picturename = "c:\bmp\anilla.bmp"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_agenda
integer x = 1568
integer y = 152
integer width = 1262
integer height = 1648
integer taborder = 60
string dataobject = "dw_agenda2"
boolean livescroll = true
end type

event doubleclicked;if isnull(row) then return
if row=0 then return


str_parametros lstr_param

lstr_param.i_nargumentos=2

lstr_param.s_argumentos[2]=getitemstring(row,"codigo")

OpenWithParm(wi_mant_clientes2,lstr_param)  

end event

type tab_1 from tab within w_agenda
integer x = 32
integer y = 124
integer width = 2990
integer height = 1700
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean fixedwidth = true
boolean multiline = true
boolean raggedright = true
boolean showpicture = false
boolean perpendiculartext = true
tabposition tabposition = tabsonleftandright!
alignment alignment = center!
tabpage_a tabpage_a
tabpage_c tabpage_c
tabpage_e tabpage_e
tabpage_g tabpage_g
tabpage_i tabpage_i
tabpage_k tabpage_k
tabpage_m tabpage_m
tabpage_ny tabpage_ny
tabpage_p tabpage_p
tabpage_r tabpage_r
tabpage_t tabpage_t
tabpage_v tabpage_v
tabpage_x tabpage_x
tabpage_z tabpage_z
end type

on tab_1.create
this.tabpage_a=create tabpage_a
this.tabpage_c=create tabpage_c
this.tabpage_e=create tabpage_e
this.tabpage_g=create tabpage_g
this.tabpage_i=create tabpage_i
this.tabpage_k=create tabpage_k
this.tabpage_m=create tabpage_m
this.tabpage_ny=create tabpage_ny
this.tabpage_p=create tabpage_p
this.tabpage_r=create tabpage_r
this.tabpage_t=create tabpage_t
this.tabpage_v=create tabpage_v
this.tabpage_x=create tabpage_x
this.tabpage_z=create tabpage_z
this.Control[]={this.tabpage_a,&
this.tabpage_c,&
this.tabpage_e,&
this.tabpage_g,&
this.tabpage_i,&
this.tabpage_k,&
this.tabpage_m,&
this.tabpage_ny,&
this.tabpage_p,&
this.tabpage_r,&
this.tabpage_t,&
this.tabpage_v,&
this.tabpage_x,&
this.tabpage_z}
end on

on tab_1.destroy
destroy(this.tabpage_a)
destroy(this.tabpage_c)
destroy(this.tabpage_e)
destroy(this.tabpage_g)
destroy(this.tabpage_i)
destroy(this.tabpage_k)
destroy(this.tabpage_m)
destroy(this.tabpage_ny)
destroy(this.tabpage_p)
destroy(this.tabpage_r)
destroy(this.tabpage_t)
destroy(this.tabpage_v)
destroy(this.tabpage_x)
destroy(this.tabpage_z)
end on

event selectionchanged;string n,n1,n2
if newindex<1 then return
n=tab_1.control[newindex].text

n1=left(n,1)
n2=right(n,1)

dw_1.retrieve(n1,codigo_empresa)
dw_2.retrieve(n2,codigo_empresa)
end event

type tabpage_a from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "A-B"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_c from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "C-D"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_e from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "E-F"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_g from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "G-H"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_i from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "I-J"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_k from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "K-L"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_m from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "M-N"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_ny from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "Ñ-O"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_p from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "P-Q"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_r from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "R-S"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_t from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "T-U"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_v from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "V-W"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_x from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "X-Y"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_z from userobject within tab_1
integer x = 174
integer y = 16
integer width = 2642
integer height = 1668
long backcolor = 16777215
string text = "Z"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

