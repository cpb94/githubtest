$PBExportHeader$wi_mant_contabalpartidanpgc.srw
forward
global type wi_mant_contabalpartidanpgc from wi_mvent_con_empresa
end type
type gb_1 from groupbox within wi_mant_contabalpartidanpgc
end type
type ddlb_1 from dropdownlistbox within wi_mant_contabalpartidanpgc
end type
type st_3 from statictext within wi_mant_contabalpartidanpgc
end type
type st_4 from statictext within wi_mant_contabalpartidanpgc
end type
type uo_balance from u_em_campo_2 within wi_mant_contabalpartidanpgc
end type
type st_5 from statictext within wi_mant_contabalpartidanpgc
end type
type st_6 from statictext within wi_mant_contabalpartidanpgc
end type
type uo_grupo from u_em_campo_2 within wi_mant_contabalpartidanpgc
end type
type uo_subgrupo from u_em_campo_2 within wi_mant_contabalpartidanpgc
end type
end forward

global type wi_mant_contabalpartidanpgc from wi_mvent_con_empresa
integer width = 2715
integer height = 1292
gb_1 gb_1
ddlb_1 ddlb_1
st_3 st_3
st_4 st_4
uo_balance uo_balance
st_5 st_5
st_6 st_6
uo_grupo uo_grupo
uo_subgrupo uo_subgrupo
end type
global wi_mant_contabalpartidanpgc wi_mant_contabalpartidanpgc

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Partidas por Balance,Bloque, Grupo y Subgrupo"
	istr_parametros.s_listado         = ""
   This.title = istr_parametros.s_titulo_ventana
	tipo_mantenimiento='C'
   ddlb_1.selectitem("D",1)
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
		ddlb_1.text=ddlb_1.item[ddlb_1.finditem(istr_parametros.s_argumentos[2],1)]
      sle_valor.text=istr_parametros.s_argumentos[3]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) then
        dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	uo_balance.em_campo.setfocus()	
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codbal",uo_balance.em_codigo.text)
 dw_1.setitem(dw_1.getrow(),"bloque",Left(ddlb_1.text,1))
 dw_1.setitem(dw_1.getrow(),"grupo",uo_grupo.em_codigo.text)
 dw_1.setitem(dw_1.getrow(),"subgrupo",uo_subgrupo.em_codigo.text)
 dw_1.setitem(dw_1.getrow(),"partida",sle_valor.text)
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(left(ddlb_1.text,1)))
criterio[2]   =  trim(left(ddlb_1.text,1))+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "contabalpartida"

dw_1.Retrieve(codigo_empresa,uo_balance.em_codigo.text,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_contabalpartidanpgc.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.st_4=create st_4
this.uo_balance=create uo_balance
this.st_5=create st_5
this.st_6=create st_6
this.uo_grupo=create uo_grupo
this.uo_subgrupo=create uo_subgrupo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_balance
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.uo_grupo
this.Control[iCurrent+9]=this.uo_subgrupo
end on

on wi_mant_contabalpartidanpgc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_balance)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.uo_grupo)
destroy(this.uo_subgrupo)
end on

event ue_activa_claves;call super::ue_activa_claves;uo_balance.em_campo.enabled = true
uo_grupo.em_campo.enabled = true
uo_subgrupo.em_campo.enabled = true
ddlb_1.enabled = true
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;uo_balance.em_campo.enabled 	= false
uo_grupo.em_campo.enabled 		= false
uo_subgrupo.em_campo.enabled 	= false
ddlb_1.enabled 					= false
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contabalpartidanpgc
integer x = 32
integer y = 676
integer width = 2514
integer height = 328
string dataobject = "dw_contabalpartidanpgc"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contabalpartidanpgc
integer x = 96
integer y = 328
integer width = 293
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Grupo :"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contabalpartidanpgc
integer x = 1632
integer y = 532
integer width = 297
integer height = 84
integer weight = 400
fontcharset fontcharset = ansi!
end type

event cb_insertar::clicked;dw_1.accepttext( )
IF cb_Insertar.enabled=TRUE THEN
	// CAMPOS OBLIGATORIOS
	if isnull(dw_1.object.titulo[1]) or trim(dw_1.object.titulo[1]) = "" then
		messagebox("El campo no puede ser nulo", "El campo titulo no puede ser nulo")
		dw_1.setfocus()
		dw_1.setrow(1)
		dw_1.setcolumn("titulo")
		return	
	end if
END IF
CALL Super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contabalpartidanpgc
integer x = 1934
integer y = 532
integer width = 297
integer height = 84
integer weight = 400
fontcharset fontcharset = ansi!
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contabalpartidanpgc
integer x = 407
integer y = 524
integer width = 553
integer taborder = 50
integer weight = 400
end type

event sle_valor::getfocus;call super::getfocus;string f1,f2,f3,f4

ue_datawindow  = "dw_ayuda_contabalpartidanpgc"
ue_titulo      = "AYUDA SELECCION DE PARTIDAS"
f1			      = " bloque = '"+left(ddlb_1.text,1)+"'"
f2					= " and codbal = '"+trim(uo_balance.em_codigo.text)+"'"
f3					= " and grupo  = '" + trim(uo_grupo.em_codigo.text)+"'"
f4					= " and subgrupo  = '" + trim(uo_subgrupo.em_codigo.text)+"'"
ue_filtro		= f1 + f2 + f3 + f4

if ddlb_1.text="" then ddlb_1.setfocus()




end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contabalpartidanpgc
integer x = 2235
integer y = 532
integer width = 297
integer height = 84
integer weight = 400
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contabalpartidanpgc
integer taborder = 60
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contabalpartidanpgc
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contabalpartidanpgc
integer width = 2679
end type

type gb_1 from groupbox within wi_mant_contabalpartidanpgc
integer x = 1614
integer y = 496
integer width = 933
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type ddlb_1 from dropdownlistbox within wi_mant_contabalpartidanpgc
integer x = 2217
integer y = 228
integer width = 416
integer height = 296
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Debe","Haber"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;DW_1.RESET()	
uo_grupo.em_codigo.text = ""
uo_grupo.em_campo.text = ""
uo_subgrupo.em_codigo.text = ""
uo_subgrupo.em_campo.text = ""
sle_valor.text = ""

end event

type st_3 from statictext within wi_mant_contabalpartidanpgc
integer x = 55
integer y = 232
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Balance :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_contabalpartidanpgc
integer x = 1934
integer y = 244
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Bloque :"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_balance from u_em_campo_2 within wi_mant_contabalpartidanpgc
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 407
integer y = 228
integer width = 1504
integer height = 80
integer taborder = 10
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabalnpgc(codigo_empresa,uo_balance.em_codigo.text)
IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabalnpgc"
ue_filtro     = ""
end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within wi_mant_contabalpartidanpgc
integer x = 5
integer y = 420
integer width = 384
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Subgrupo :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within wi_mant_contabalpartidanpgc
integer x = 23
integer y = 524
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Partida :"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_grupo from u_em_campo_2 within wi_mant_contabalpartidanpgc
event destroy ( )
integer x = 407
integer y = 328
integer width = 1504
integer height = 80
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

event modificado;string bal 
bal = uo_balance.em_codigo.text
uo_grupo.em_campo.text=f_nombre_contabalgrupnpgc(codigo_empresa,bal,left(ddlb_1.text,1),uo_grupo.em_codigo.text)

IF Trim(uo_grupo.em_campo.text)="" THEN 
 IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
 uo_grupo.em_campo.text=""
 uo_grupo.em_codigo.text=""
END IF

dw_1.reset()
uo_subgrupo.em_codigo.text = ""
uo_subgrupo.em_campo.text = ""
sle_valor.text = ""
end event

event getfocus;call super::getfocus;string f1,f2
      		
ue_titulo     = "AYUDA SELECCION DE GRUPOS"
ue_datawindow = "dw_ayuda_contabalgrupnpgc"
f1 = " bloque = '"+left(ddlb_1.text,1)+"'"
f2 = " and codbal = '" + uo_balance.em_codigo.text + "'"
ue_filtro  = f1 + f2   



end event

type uo_subgrupo from u_em_campo_2 within wi_mant_contabalpartidanpgc
event destroy ( )
integer x = 407
integer y = 420
integer width = 1504
integer height = 80
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_subgrupo.destroy
call u_em_campo_2::destroy
end on

event modificado;string bal

bal = uo_balance.em_codigo.text

uo_subgrupo.em_campo.text=f_nombre_contabalsubgrupnpgc(codigo_empresa,bal,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text)



dw_1.reset()
sle_valor.text = ""



end event

event getfocus;call super::getfocus;string f1,f2,f3

ue_titulo     = "AYUDA SELECCION DE SUBGRUPOS"
ue_datawindow = "dw_ayuda_contabalsubgrupnpgc"

f1 = " codbal = '" + uo_balance.em_codigo.text + "'"
f2 = " and bloque = '"+left(ddlb_1.text,1)+"'"
f3 = " and grupo = '"+uo_grupo.em_codigo.text+"'"

ue_filtro = f1 + f2 + f3    

end event

