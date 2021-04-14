$PBExportHeader$w_control_calidad.srw
forward
global type w_control_calidad from w_int_con_empresa
end type
type dw_1 from datawindow within w_control_calidad
end type
type st_8 from statictext within w_control_calidad
end type
type gb_5 from groupbox within w_control_calidad
end type
type gb_4 from groupbox within w_control_calidad
end type
type gb_3 from groupbox within w_control_calidad
end type
type gb_2 from groupbox within w_control_calidad
end type
type cb_1 from commandbutton within w_control_calidad
end type
type cb_2 from commandbutton within w_control_calidad
end type
type gb_1 from groupbox within w_control_calidad
end type
type st_cli from statictext within w_control_calidad
end type
type st_fecha from statictext within w_control_calidad
end type
type st_anyo from statictext within w_control_calidad
end type
type st_alb from statictext within w_control_calidad
end type
type st_1 from statictext within w_control_calidad
end type
type gb_6 from groupbox within w_control_calidad
end type
type p_1 from picture within w_control_calidad
end type
end forward

global type w_control_calidad from w_int_con_empresa
integer x = 55
integer y = 268
integer width = 2830
integer height = 1536
string icon = "Application!"
dw_1 dw_1
st_8 st_8
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
st_cli st_cli
st_fecha st_fecha
st_anyo st_anyo
st_alb st_alb
st_1 st_1
gb_6 gb_6
p_1 p_1
end type
global w_control_calidad w_control_calidad

type variables
string tipo_apertura,materia_prima,cliente
long linea_alb


end variables

on w_control_calidad.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_8=create st_8
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.st_cli=create st_cli
this.st_fecha=create st_fecha
this.st_anyo=create st_anyo
this.st_alb=create st_alb
this.st_1=create st_1
this.gb_6=create gb_6
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_8
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_cli
this.Control[iCurrent+11]=this.st_fecha
this.Control[iCurrent+12]=this.st_anyo
this.Control[iCurrent+13]=this.st_alb
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.gb_6
this.Control[iCurrent+16]=this.p_1
end on

on w_control_calidad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_8)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.st_cli)
destroy(this.st_fecha)
destroy(this.st_anyo)
destroy(this.st_alb)
destroy(this.st_1)
destroy(this.gb_6)
destroy(this.p_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Control Calidad"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)

   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      tipo_apertura=istr_parametros.s_argumentos[2]
      st_anyo.text=istr_parametros.s_argumentos[3]
      st_alb.text=istr_parametros.s_argumentos[4]
      linea_alb=long(istr_parametros.s_argumentos[5])
      materia_prima=istr_parametros.s_argumentos[6]
		cliente=istr_parametros.s_argumentos[7]
		st_cli.text=f_nombre_proveedor(codigo_empresa,cliente)
		st_fecha.text=istr_parametros.s_argumentos[8]
      IF Trim(tipo_apertura)<>"" and Not IsNull(tipo_apertura) Then
			dw_1.retrieve(codigo_empresa,materia_prima)
		END IF
	END IF
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_control_calidad
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_control_calidad
end type

type st_empresa from w_int_con_empresa`st_empresa within w_control_calidad
integer x = 37
integer y = 28
integer width = 2432
end type

type dw_1 from datawindow within w_control_calidad
integer x = 37
integer y = 320
integer width = 2007
integer height = 964
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_control_calidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;if rowcount=0 then
	if messagebox("Materia Prima sin Pruebas",materia_prima+" no tiene pruebas asignadas. Desea continuar",Question!,Yesno!) =1 then
		closewithreturn(parent,"Bien")
	else
		closewithreturn(parent,"N")
	end if
	return
end if

long i

for i=1 to rowcount
	setitem(i,"compruebaprima_pasa","S")
next

if tipo_apertura="B" then cb_1.triggerevent(clicked!)

end event

type st_8 from statictext within w_control_calidad
integer x = 347
integer y = 216
integer width = 46
integer height = 76
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_control_calidad
integer x = 1115
integer y = 148
integer width = 928
integer height = 168
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Proveedor"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_control_calidad
integer x = 690
integer y = 148
integer width = 421
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Fecha"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_control_calidad
integer x = 2048
integer y = 148
integer width = 640
integer height = 168
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_control_calidad
integer x = 2048
integer y = 292
integer width = 640
integer height = 508
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_control_calidad
integer x = 2057
integer y = 184
integer width = 315
integer height = 124
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;long i
datetime fecha
fecha=datetime(date(st_fecha.text))

for i=1 to dw_1.rowcount()
	string prueba,valor
	prueba=dw_1.getitemstring(i,"prueba")
	valor=dw_1.getitemstring(i,"compruebaprima_pasa")

	INSERT INTO compruebaprima  
			 (empresa,anyo,albaran,linea,   
			  fecha,proveedor,mprima,   
			  prueba,pasa )  
	VALUES (:codigo_empresa,:st_anyo.text,:st_alb.text,:linea_alb,   
			  :fecha,:cliente,:materia_prima,   
			  :prueba,:valor )  ;
next

closewithreturn(parent,"Bien")
end event

type cb_2 from commandbutton within w_control_calidad
integer x = 2373
integer y = 184
integer width = 306
integer height = 124
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;closewithreturn(parent,"N")
end event

type gb_1 from groupbox within w_control_calidad
integer x = 37
integer y = 148
integer width = 649
integer height = 168
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Albrarán de Compras"
borderstyle borderstyle = styleraised!
end type

type st_cli from statictext within w_control_calidad
integer x = 1138
integer y = 216
integer width = 878
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_fecha from statictext within w_control_calidad
integer x = 713
integer y = 216
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_anyo from statictext within w_control_calidad
integer x = 78
integer y = 216
integer width = 265
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type st_alb from statictext within w_control_calidad
integer x = 398
integer y = 216
integer width = 265
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_control_calidad
integer x = 2080
integer y = 820
integer width = 558
integer height = 452
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Complete el panel con los resultados de las pruebas. <Aceptar> para salir y grabar cambios. <Cancelar> sale sin grabar y no controla la linea. "
boolean focusrectangle = false
end type

type gb_6 from groupbox within w_control_calidad
integer x = 2048
integer y = 776
integer width = 640
integer height = 508
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type p_1 from picture within w_control_calidad
integer x = 2139
integer y = 364
integer width = 457
integer height = 400
boolean bringtotop = true
string picturename = "c:\bmp\controlcalidad.bmp"
boolean focusrectangle = false
end type

