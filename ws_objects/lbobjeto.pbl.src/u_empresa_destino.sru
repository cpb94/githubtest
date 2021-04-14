$PBExportHeader$u_empresa_destino.sru
forward
global type u_empresa_destino from UserObject
end type
type cb_cancelar from commandbutton within u_empresa_destino
end type
type cb_procesar from commandbutton within u_empresa_destino
end type
type uo_empresa from u_em_campo_2 within u_empresa_destino
end type
type gb_empresa from groupbox within u_empresa_destino
end type
end forward

global type u_empresa_destino from UserObject
int Width=1358
int Height=216
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_procesar pbm_custom01
event ue_cancelar pbm_custom02
cb_cancelar cb_cancelar
cb_procesar cb_procesar
uo_empresa uo_empresa
gb_empresa gb_empresa
end type
global u_empresa_destino u_empresa_destino

event ue_procesar;This.visible=false
end event

event ue_cancelar;This.visible=false
end event

on u_empresa_destino.create
this.cb_cancelar=create cb_cancelar
this.cb_procesar=create cb_procesar
this.uo_empresa=create uo_empresa
this.gb_empresa=create gb_empresa
this.Control[]={this.cb_cancelar,&
this.cb_procesar,&
this.uo_empresa,&
this.gb_empresa}
end on

on u_empresa_destino.destroy
destroy(this.cb_cancelar)
destroy(this.cb_procesar)
destroy(this.uo_empresa)
destroy(this.gb_empresa)
end on

type cb_cancelar from commandbutton within u_empresa_destino
int X=1042
int Y=112
int Width=274
int Height=64
int TabOrder=30
boolean BringToTop=true
string Text="cancelar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Triggerevent("ue_cancelar")
end event

type cb_procesar from commandbutton within u_empresa_destino
int X=1042
int Y=48
int Width=274
int Height=64
int TabOrder=20
boolean BringToTop=true
string Text="procesar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF IsNull(uo_empresa.em_codigo.text) or Trim(uo_empresa.em_codigo.text) = "" then
	f_mensaje("Traspaso de datos","Ha de seleccionar la empresa destino")
	return
end if

Parent.TriggerEvent("ue_procesar")
end event

type uo_empresa from u_em_campo_2 within u_empresa_destino
event destroy ( )
int X=50
int Y=76
int Width=965
int TabOrder=10
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type

on uo_empresa.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_empresa.em_campo.text=f_nombre_empresa2(uo_empresa.em_codigo.text)

If Trim(uo_empresa.em_campo.text)="" then
	uo_empresa.em_campo.text=""
	uo_empresa.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow     = "dw_ayuda_empresas"
ue_filtro         = "empresa <> '" + codigo_empresa + "'"
valor_empresa=FALSE
end event

type gb_empresa from groupbox within u_empresa_destino
int X=23
int Width=1312
int Height=192
string Text="Empresa destino"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

