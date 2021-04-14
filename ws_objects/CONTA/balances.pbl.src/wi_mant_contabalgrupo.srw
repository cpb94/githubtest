$PBExportHeader$wi_mant_contabalgrupo.srw
forward
global type wi_mant_contabalgrupo from wi_mvent_con_empresa
end type
type gb_1 from groupbox within wi_mant_contabalgrupo
end type
type ddlb_1 from dropdownlistbox within wi_mant_contabalgrupo
end type
type mle_1 from multilineedit within wi_mant_contabalgrupo
end type
type st_2 from statictext within wi_mant_contabalgrupo
end type
type st_3 from statictext within wi_mant_contabalgrupo
end type
type st_4 from statictext within wi_mant_contabalgrupo
end type
type uo_balance from u_em_campo_2 within wi_mant_contabalgrupo
end type
end forward

global type wi_mant_contabalgrupo from wi_mvent_con_empresa
integer width = 2688
integer height = 1672
gb_1 gb_1
ddlb_1 ddlb_1
mle_1 mle_1
st_2 st_2
st_3 st_3
st_4 st_4
uo_balance uo_balance
end type
global wi_mant_contabalgrupo wi_mant_contabalgrupo

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Grupos por Balance y Bloque"
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
 dw_1.setitem(dw_1.getrow(),"bloque",Left(ddlb_1.text,1))
 dw_1.setitem(dw_1.getrow(),"grupo",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"codbal",uo_balance.em_codigo.text)

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
tabla         =  "contaplan"

dw_1.Retrieve(codigo_empresa,uo_balance.em_codigo.text,left(ddlb_1.text,1),sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_contabalgrupo.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.ddlb_1=create ddlb_1
this.mle_1=create mle_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.uo_balance=create uo_balance
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.uo_balance
end on

on wi_mant_contabalgrupo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.ddlb_1)
destroy(this.mle_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_balance)
end on

event ue_activa_claves;call super::ue_activa_claves;uo_balance.em_campo.enabled = true
ddlb_1.enabled = true
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;uo_balance.em_campo.enabled = false
ddlb_1.enabled = false
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contabalgrupo
integer x = 23
integer y = 472
integer width = 2514
integer height = 324
string dataobject = "dw_contabalgrup"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contabalgrupo
integer x = 1952
integer y = 152
integer width = 293
string text = "Grupo"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contabalgrupo
integer x = 1618
integer y = 368
integer width = 297
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contabalgrupo
integer x = 1920
integer y = 368
integer width = 297
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contabalgrupo
integer x = 1957
integer y = 228
integer width = 288
integer height = 96
integer taborder = 30
end type

event sle_valor::getfocus;call super::getfocus;string f1,f2

ue_datawindow  = "dw_ayuda_contabalgrup"
ue_titulo      = "AYUDA SELECCION DE GRUPOS"
f1			      = " bloque = '"+left(ddlb_1.text,1)+"'"
f2					= " and codbal = '"+trim(uo_balance.em_codigo.text)+"'"
ue_filtro		= f1 + f2
if ddlb_1.text="" then ddlb_1.setfocus()
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contabalgrupo
integer x = 2222
integer y = 368
integer width = 297
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contabalgrupo
integer taborder = 50
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contabalgrupo
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contabalgrupo
integer width = 2834
end type

type gb_1 from groupbox within wi_mant_contabalgrupo
integer x = 1600
integer y = 332
integer width = 933
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type ddlb_1 from dropdownlistbox within wi_mant_contabalgrupo
integer x = 1467
integer y = 228
integer width = 485
integer height = 296
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Debe","Haber"}
end type

type mle_1 from multilineedit within wi_mant_contabalgrupo
integer x = 279
integer y = 832
integer width = 2158
integer height = 560
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Si el grupo tiene una fórmula para calcular su saldo, introduzcala siguiendo el siguiente esquema: .      1.- Los totales de Grupo deben llevar una G delante del código de Grupo.                                             .      2.- Los totales de Subgrupo deben llevar una S delante del código de Subgrupo.                       .      3.- Construya la fórmula concatenando G y S con el código del total correspondiente               .           y con + o - según sume o reste.                                                                                              Ejemplo:                                                                                                                                                .       GH1+GH2+SH11+SH12+SH13+SH21+SH22-GD1-GD2-SD11-SD21                                            .       Se sumaran los grupos H1, H2 y los subgrupos H11, H12, H13, H21, H22; y se restarán los      .       grupos D1, D2 y los subgrupos D11,D21."
boolean border = false
end type

type st_2 from statictext within wi_mant_contabalgrupo
integer x = 96
integer y = 836
integer width = 151
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Nota:"
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_contabalgrupo
integer x = 82
integer y = 152
integer width = 1385
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Balance"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_contabalgrupo
integer x = 1467
integer y = 152
integer width = 480
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Bloque"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_balance from u_em_campo_2 within wi_mant_contabalgrupo
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 87
integer y = 228
integer width = 1385
integer height = 96
integer taborder = 10
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabal(codigo_empresa,uo_balance.em_codigo.text)
IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabal"
ue_filtro     = ""

end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

