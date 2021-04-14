$PBExportHeader$w_mant_horarios_crosstab.srw
forward
global type w_mant_horarios_crosstab from window
end type
type ddlb_1 from dropdownlistbox within w_mant_horarios_crosstab
end type
type dw_1 from datawindow within w_mant_horarios_crosstab
end type
type em_anyo from editmask within w_mant_horarios_crosstab
end type
type uo_calendario from u_em_campo_2 within w_mant_horarios_crosstab
end type
type cb_generar from commandbutton within w_mant_horarios_crosstab
end type
type gb_6 from groupbox within w_mant_horarios_crosstab
end type
type gb_5 from groupbox within w_mant_horarios_crosstab
end type
type r_4 from rectangle within w_mant_horarios_crosstab
end type
type r_1 from rectangle within w_mant_horarios_crosstab
end type
type r_2 from rectangle within w_mant_horarios_crosstab
end type
end forward

global type w_mant_horarios_crosstab from window
integer width = 8608
integer height = 3468
boolean titlebar = true
string title = "Mostrar calendarios"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ddlb_1 ddlb_1
dw_1 dw_1
em_anyo em_anyo
uo_calendario uo_calendario
cb_generar cb_generar
gb_6 gb_6
gb_5 gb_5
r_4 r_4
r_1 r_1
r_2 r_2
end type
global w_mant_horarios_crosstab w_mant_horarios_crosstab

on w_mant_horarios_crosstab.create
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.em_anyo=create em_anyo
this.uo_calendario=create uo_calendario
this.cb_generar=create cb_generar
this.gb_6=create gb_6
this.gb_5=create gb_5
this.r_4=create r_4
this.r_1=create r_1
this.r_2=create r_2
this.Control[]={this.ddlb_1,&
this.dw_1,&
this.em_anyo,&
this.uo_calendario,&
this.cb_generar,&
this.gb_6,&
this.gb_5,&
this.r_4,&
this.r_1,&
this.r_2}
end on

on w_mant_horarios_crosstab.destroy
destroy(this.ddlb_1)
destroy(this.dw_1)
destroy(this.em_anyo)
destroy(this.uo_calendario)
destroy(this.cb_generar)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.r_4)
destroy(this.r_1)
destroy(this.r_2)
end on

event open;em_anyo.text = String(Year(Today()))

ddlb_1.selectitem(Integer(Month(Today())))




end event

type ddlb_1 from dropdownlistbox within w_mant_horarios_crosstab
integer x = 1897
integer y = 104
integer width = 407
integer height = 680
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_mant_horarios_crosstab
integer x = 27
integer y = 236
integer width = 8494
integer height = 3096
integer taborder = 30
string title = "none"
string dataobject = "dw_mant_horarios_crosstab"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;string elemento, s_columna

integer fila, columna, mes

string ls_columna,ls_valor,ls_nuevo_valor




elemento = dwo.name

if left(elemento,6) = 'activa' and row > 0 then
	
	s_columna = mid(elemento,8,len(elemento))
		
	columna = integer(s_columna)+1
	
	fila = row - 1
	
	mes = ddlb_1.FindItem(ddlb_1.Text,0)
	
	ls_columna = dwo.name
			
	ls_valor = this.getitemstring(row,ls_columna)
	
	if ls_valor = 'S' then
			ls_nuevo_valor = 'N'
	else
			ls_nuevo_valor = 'S'
	end if
					
	/*		
	
	select activa
	into :estado
	from horarios
	where calendario = :uo_calendario.em_codigo.text
	and anyo = :em_anyo.text
	and hora = :fila
	and dia = :columna
	and mes = :mes
	using SQLCA;
	
	*/
	update horarios
	set activa = :ls_nuevo_valor
	where calendario = :uo_calendario.em_codigo.text
	and anyo = :em_anyo.text
	and hora = :fila
	and dia = :columna
	and mes = :mes
	using SQLCA;
	
	if SQLCA.SQLCode <> 0 then
		rollback;
		messagebox ("Error","No se pudo actualizar el calendario")
	else
		commit;		
		this.setitem(row,ls_columna,ls_nuevo_valor)	
	end if
	
end if
end event

type em_anyo from editmask within w_mant_horarios_crosstab
integer x = 1513
integer y = 108
integer width = 329
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
double increment = 1
string minmax = "~~"
end type

type uo_calendario from u_em_campo_2 within w_mant_horarios_crosstab
event destroy ( )
integer x = 73
integer y = 112
integer width = 1381
integer height = 76
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calendario.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;string des_calendario
integer mes

select descripcion
into :des_calendario
from prodcalendarios
where codigo = :uo_calendario.em_codigo.text;

uo_calendario.em_campo.text = des_calendario
IF Trim(uo_calendario.em_campo.text)="" THEN 
 IF Trim(uo_calendario.em_codigo.text)<>"" Then uo_calendario.em_campo.SetFocus()
 uo_calendario.em_campo.text=""
 uo_calendario.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;valor_empresa = false
ue_titulo     = "Ayuda seleccion de Calendarios"
ue_datawindow = "dw_ayuda_calendarios"
ue_filtro     = ""

end event

type cb_generar from commandbutton within w_mant_horarios_crosstab
integer x = 7954
integer y = 52
integer width = 389
integer height = 140
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar"
end type

event clicked;dw_1.SetTransObject(SQLCA)

dw_1.retrieve(uo_calendario.em_codigo.text,integer(em_anyo.text),codigo_empresa, ddlb_1.text)
end event

type gb_6 from groupbox within w_mant_horarios_crosstab
integer x = 1490
integer y = 56
integer width = 370
integer height = 140
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
end type

type gb_5 from groupbox within w_mant_horarios_crosstab
integer x = 50
integer y = 56
integer width = 1426
integer height = 140
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 79741120
string text = "Calendario"
end type

type r_4 from rectangle within w_mant_horarios_crosstab
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 21642288
integer x = 27
integer y = 40
integer width = 1856
integer height = 164
end type

type r_1 from rectangle within w_mant_horarios_crosstab
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 21642288
integer x = 1883
integer y = 88
integer width = 439
integer height = 116
end type

type r_2 from rectangle within w_mant_horarios_crosstab
integer linethickness = 4
long fillcolor = 16777215
integer x = 4704
integer y = 1196
integer width = 329
integer height = 176
end type

