$PBExportHeader$w_int_cuadro_analitica_volcado.srw
forward
global type w_int_cuadro_analitica_volcado from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_cuadro_analitica_volcado
end type
type em_fechadesde from u_em_campo within w_int_cuadro_analitica_volcado
end type
type cb_consulta from u_boton within w_int_cuadro_analitica_volcado
end type
type em_fechahasta from u_em_campo within w_int_cuadro_analitica_volcado
end type
type st_1 from statictext within w_int_cuadro_analitica_volcado
end type
type uo_bal from u_em_campo_2 within w_int_cuadro_analitica_volcado
end type
type st_2 from statictext within w_int_cuadro_analitica_volcado
end type
type st_33 from statictext within w_int_cuadro_analitica_volcado
end type
type gb_1 from groupbox within w_int_cuadro_analitica_volcado
end type
end forward

global type w_int_cuadro_analitica_volcado from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2889
integer height = 1540
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
uo_bal uo_bal
st_2 st_2
st_33 st_33
gb_1 gb_1
end type
global w_int_cuadro_analitica_volcado w_int_cuadro_analitica_volcado

type variables
Dec hoja
String vn
end variables

forward prototypes
public subroutine f_volcar ()
end prototypes

public subroutine f_volcar ();Dec   importe,digitos,ejer,digotos,xx,digitos_cta
Boolean bus
DateTime  fechad,fechah
STring coste,cta,codigo
DataStore dw_data

digitos   = f_digitos_analitica_segundo_nivel()
fechad    = Datetime(Date(String(em_fechadesde.Text)))
fechah    = Datetime(Date(String(em_fechahasta.Text)))
ejer      = Year(Date(fechad))

SELECT  contaparam.digitos  INTO  :digitos_cta  FROM  contaparam  
WHERE   contaparam.ejercicio = :ejer
AND     contaparam.empresa   = :codigo_empresa;
		

String sel
Datastore  dw
f_mensaje_proceso("Procesando",1,100)
Sel = +&
  " SELECT SubString(costesapu.coste,1,"  + STring(digitos,"###############")+") cost ,       "  + &
  "        SubString(costesapu.cuenta,1," + String(digitos_cta,"##############") + ") cta,    "  + &
  "        Sum(debe-haber) imp  " + &
  " FROM costesapu " + &
  " WHERE  costesapu.ejercicio = "  +String(ejercicio_activo,"####") +&
  " AND    costesapu.empresa = '"       + codigo_empresa   + "'"  + &
  " AND    costesapu.fapunte between '"   + String(fechad,"dd/mm/yyyy") + "'  AND  '"+String(fechah,"dd/mm/yyyy")+"'      "  + &
  "   GROUP BY SubString(costesapu.coste,1,"  + String(digitos,    "##############")+"),"  + &
  "            SubString(costesapu.cuenta,1," + String(digitos_cta,"##############")+")"  + &
  " ORDER BY SubString(costesapu.coste,1," + String(digitos,"#############")+") ASC,      "  +&
  "          SubString(costesapu.cuenta,1,"+ String(digitos_cta,"#############")+") ASC  "   

//  dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
    
//	f_mensaje("",sel)  
	
	
  For xx = 1 To dw.Rowcount()
			f_mensaje_proceso("Procesando",xx,dw.RowCount())
			codigo   =  uo_bal.em_codigo.text
			coste    =  dw.Object.cost[xx]
			cta      =  dw.Object.cta[xx]
			importe  =  dw.Object.imp[xx]
//		  INSERT INTO costesapuman (codigo,empresa,coste,importe,cuenta)  
//							     VALUES (:codigo,:codigo_empresa,:coste,:importe,:cta);

  Next
  
  COMMIT;
  
destroy dw  
  
end subroutine

event open;call super::open;This.title = "VOLCADO CUADRO DE ANALITICA"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(RelativeDate(MDY(01,01,Year(Today())+1),-1))






end event

on w_int_cuadro_analitica_volcado.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.uo_bal=create uo_bal
this.st_2=create st_2
this.st_33=create st_33
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.uo_bal
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_33
this.Control[iCurrent+9]=this.gb_1
end on

on w_int_cuadro_analitica_volcado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.uo_bal)
destroy(this.st_2)
destroy(this.st_33)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_cuadro_analitica_volcado
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_cuadro_analitica_volcado
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_cuadro_analitica_volcado
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_int_cuadro_analitica_volcado
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_int_cuadro_analitica_volcado
integer x = 41
integer y = 208
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_consulta from u_boton within w_int_cuadro_analitica_volcado
integer x = 2117
integer y = 152
integer width = 485
integer height = 136
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
string text = "&Volcado"
end type

event clicked;IF Trim(uo_bal.em_codigo.text) = "" Then
	f_mensaje("Error Introduccion","Introduzca el codigo de cuadro")
	f_Activar_campo(uo_bal.em_campo)
	Return
END IF
f_volcar()

end event

type em_fechahasta from u_em_campo within w_int_cuadro_analitica_volcado
integer x = 361
integer y = 208
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_int_cuadro_analitica_volcado
integer x = 320
integer y = 188
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_bal from u_em_campo_2 within w_int_cuadro_analitica_volcado
event destroy ( )
integer x = 645
integer y = 208
integer width = 1431
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_bal.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_bal.em_campo.text=f_nombre_cosbal(codigo_empresa,uo_bal.em_codigo.text)
If Trim(uo_bal.em_campo.text)="" then
	uo_bal.em_campo.text=""
	uo_bal.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_cosbal"
ue_titulo      = "AYUDA SELECCION DE CUADROS"
ue_filtro      =""
end event

type st_2 from statictext within w_int_cuadro_analitica_volcado
integer x = 649
integer y = 132
integer width = 1431
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Nombre Cuadro"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_33 from statictext within w_int_cuadro_analitica_volcado
integer x = 41
integer y = 132
integer width = 608
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_int_cuadro_analitica_volcado
integer x = 2098
integer y = 104
integer width = 521
integer height = 200
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

