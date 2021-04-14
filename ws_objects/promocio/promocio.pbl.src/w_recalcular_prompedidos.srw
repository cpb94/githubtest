$PBExportHeader$w_recalcular_prompedidos.srw
forward
global type w_recalcular_prompedidos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_recalcular_prompedidos
end type
type st_1 from statictext within w_recalcular_prompedidos
end type
type cb_1 from u_boton within w_recalcular_prompedidos
end type
type dw_proceso1 from datawindow within w_recalcular_prompedidos
end type
type cliente from statictext within w_recalcular_prompedidos
end type
type st_1a from statictext within w_recalcular_prompedidos
end type
type descripcion_articulo from statictext within w_recalcular_prompedidos
end type
type dw_proceso2 from datawindow within w_recalcular_prompedidos
end type
type dw_proceso from datawindow within w_recalcular_prompedidos
end type
type st_1b from statictext within w_recalcular_prompedidos
end type
type descripcion_panel from statictext within w_recalcular_prompedidos
end type
type st_1c from statictext within w_recalcular_prompedidos
end type
type st_1d from statictext within w_recalcular_prompedidos
end type
type st_1e from statictext within w_recalcular_prompedidos
end type
type st_1f from statictext within w_recalcular_prompedidos
end type
type st_2c from statictext within w_recalcular_prompedidos
end type
type st_2d from statictext within w_recalcular_prompedidos
end type
type st_2e from statictext within w_recalcular_prompedidos
end type
type gb_1 from groupbox within w_recalcular_prompedidos
end type
type st_3c from statictext within w_recalcular_prompedidos
end type
type st_3d from statictext within w_recalcular_prompedidos
end type
type st_3e from statictext within w_recalcular_prompedidos
end type
type st_4c from statictext within w_recalcular_prompedidos
end type
type st_4d from statictext within w_recalcular_prompedidos
end type
type st_4e from statictext within w_recalcular_prompedidos
end type
type st_5c from statictext within w_recalcular_prompedidos
end type
type st_5d from statictext within w_recalcular_prompedidos
end type
type st_5e from statictext within w_recalcular_prompedidos
end type
type st_31 from statictext within w_recalcular_prompedidos
end type
type st_33 from statictext within w_recalcular_prompedidos
end type
type st_34 from statictext within w_recalcular_prompedidos
end type
type pedido from statictext within w_recalcular_prompedidos
end type
type pesot from statictext within w_recalcular_prompedidos
end type
type costet from statictext within w_recalcular_prompedidos
end type
type ventat from statictext within w_recalcular_prompedidos
end type
type pesotm from statictext within w_recalcular_prompedidos
end type
type costetm from statictext within w_recalcular_prompedidos
end type
type ventatm from statictext within w_recalcular_prompedidos
end type
type ventatp from statictext within w_recalcular_prompedidos
end type
type costetp from statictext within w_recalcular_prompedidos
end type
type pesotp from statictext within w_recalcular_prompedidos
end type
type pesop from statictext within w_recalcular_prompedidos
end type
type costep from statictext within w_recalcular_prompedidos
end type
type ventap from statictext within w_recalcular_prompedidos
end type
type coste_manipulacion from statictext within w_recalcular_prompedidos
end type
type pesom from statictext within w_recalcular_prompedidos
end type
type costem from statictext within w_recalcular_prompedidos
end type
type ventam from statictext within w_recalcular_prompedidos
end type
end forward

global type w_recalcular_prompedidos from w_int_con_empresa
integer width = 2853
integer height = 1448
pb_1 pb_1
st_1 st_1
cb_1 cb_1
dw_proceso1 dw_proceso1
cliente cliente
st_1a st_1a
descripcion_articulo descripcion_articulo
dw_proceso2 dw_proceso2
dw_proceso dw_proceso
st_1b st_1b
descripcion_panel descripcion_panel
st_1c st_1c
st_1d st_1d
st_1e st_1e
st_1f st_1f
st_2c st_2c
st_2d st_2d
st_2e st_2e
gb_1 gb_1
st_3c st_3c
st_3d st_3d
st_3e st_3e
st_4c st_4c
st_4d st_4d
st_4e st_4e
st_5c st_5c
st_5d st_5d
st_5e st_5e
st_31 st_31
st_33 st_33
st_34 st_34
pedido pedido
pesot pesot
costet costet
ventat ventat
pesotm pesotm
costetm costetm
ventatm ventatm
ventatp ventatp
costetp costetp
pesotp pesotp
pesop pesop
costep costep
ventap ventap
coste_manipulacion coste_manipulacion
pesom pesom
costem costem
ventam ventam
end type
global w_recalcular_prompedidos w_recalcular_prompedidos

type variables
Dec var_anyo,var_pedido,var_linea,var_orden


end variables

forward prototypes
public subroutine f_calculo_promped ()
public subroutine f_calculo_promlindetallped ()
public subroutine f_calculo_promlinped ()
end prototypes

public subroutine f_calculo_promped ();String v_cliente,var_tipo,var_reposicion,var_tipo_expositor
Dec  peso_panel,peso_material,coste_panel,coste_material,v_coste_manipulacion,&
     venta_panel,venta_material,var_peso_expositor,var_coste_expositor,&
	  var_venta_expositor,var_peso_total,var_coste_total,var_venta_total
Select  promped.cliente,promped.tipo ,promped.reposicion,promped.tipo_expositor
Into :v_cliente,:var_tipo,:var_reposicion,:var_tipo_expositor From promped
Where   promped.empresa = :codigo_empresa
And     promped.anyo    = :var_anyo
And     promped.pedido  = :var_pedido;
cliente.text =  v_cliente + " " + f_razon_genter(codigo_empresa,"C",v_cliente)

Select  Sum(promlinped.cantidad * promlinped.peso_panel),
        Sum(promlinped.cantidad * promlinped.coste_panel),
		  Sum(promlinped.cantidad * promlinped.venta_panel),
		  Sum(promlinped.cantidad * promlinped.peso_material),
        Sum(promlinped.cantidad * promlinped.coste_material),
		  Sum(promlinped.cantidad * promlinped.venta_material), 
  		  Sum(promlinped.cantidad * promlinped.coste_manipulacion)
Into    :peso_panel,:coste_panel,:venta_panel,
		  :peso_material,:coste_material,:venta_material,:v_coste_manipulacion
From    promlinped
Where   promlinped.empresa   =  :codigo_empresa
And     promlinped.anyo      =  :var_anyo
AND     promlinped.pedido    =  :var_pedido;
IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)



IF var_tipo = "1" Then
	var_peso_expositor  = 0
	var_coste_expositor = 0
   var_venta_expositor = 0
ELSE
	IF var_reposicion= "S" Then
	 var_peso_expositor  = 0
	 var_coste_expositor = 0
	 var_venta_expositor = 0
	ELSE
	 var_peso_expositor  = f_peso_promexpositores(codigo_empresa,var_tipo_expositor)
 	 var_coste_expositor = f_coste_promexpositores(codigo_empresa,var_tipo_expositor)
  	 var_venta_expositor = f_pventa_promexpositores(codigo_empresa,var_tipo_expositor)
	END IF
END IF
			
IF IsNull(var_peso_expositor)  Then  var_peso_expositor  = 0
IF IsNull(var_coste_expositor) Then  var_coste_expositor = 0
IF IsNull(var_venta_expositor) Then  var_venta_expositor = 0
			
var_peso_total  = var_peso_expositor  + peso_panel  + peso_material
var_coste_total = var_coste_expositor + coste_panel + coste_material + v_coste_manipulacion
var_venta_total = var_venta_expositor + venta_panel + venta_material
pesot.text   = STring(var_peso_total,f_mascara_decimales(0))
costet.text  = STring(var_coste_total,f_mascara_decimales(0))
ventat.text  = STring(var_venta_total,f_mascara_decimales(0))

pesotm.text   = STring(peso_material,f_mascara_decimales(0))
costetm.text  = STring(coste_material,f_mascara_decimales(0))
ventatm.text  = STring(venta_material,f_mascara_decimales(0))

pesotp.text   = STring(peso_panel,f_mascara_decimales(0))
costetp.text  = STring(coste_panel,f_mascara_decimales(0))
ventatp.text  = STring(venta_panel,f_mascara_decimales(0))
  UPDATE promped  
     SET peso_material   = :peso_material,   
         coste_material  = :coste_material,   
         venta_material  = :venta_material,   
         peso_total      = :var_peso_total,   
         coste_total     = :var_coste_total,   
         venta_total     = :var_venta_total,   
         peso_paneles    = :peso_panel,   
         coste_paneles   = :coste_panel,   
         venta_paneles   = :venta_panel,   
         peso_expositor  = :var_peso_expositor,   
         coste_expositor = :var_coste_expositor,   
         venta_expositor = :var_venta_expositor,   
         coste_manipulacion = :v_coste_manipulacion  
   WHERE ( promped.empresa = :codigo_empresa ) AND  
         ( promped.anyo = :var_anyo ) AND  
         ( promped.pedido = :var_pedido );
			IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
		COMMIT;

		  
end subroutine

public subroutine f_calculo_promlindetallped ();
String articulo,calidad,formato,var_empresa,var_articulo,var_calidad
Dec{2} peso,cantidad,var_precio
Dec{0} venta,coste,piezas

  SELECT promlindetallped.articulo,promlindetallped.calidad,promlindetallped.piezas  
    INTO :articulo,:calidad,:piezas  
    FROM promlindetallped  
   WHERE promlindetallped.empresa = :codigo_empresa 
	AND   promlindetallped.anyo    = :var_anyo 
	AND   promlindetallped.pedido  = :var_pedido 
	AND   promlindetallped.linea   = :var_linea 
	AND   promlindetallped.orden   = :var_orden;
	IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
descripcion_articulo.text = f_nombre_articulo(codigo_empresa,articulo)
cantidad = f_conversion_piezas_cantidad_bis(codigo_empresa,articulo,piezas)


calidad  = f_calidad_promparam(codigo_empresa)
formato = f_formato_articulo(codigo_empresa,articulo)
peso    = f_peso_articulo(codigo_empresa,articulo)
coste   = f_coste_articulo(codigo_empresa,articulo)
IF IsNull(coste) Then coste = 0
IF IsNull(peso) Then peso = 0

venta  = &
f_precio_articulo_venlintarifas(codigo_empresa,&
                           	  f_tarifa_promparam(codigo_empresa),&
								        f_activa_ventarifas(codigo_empresa,f_tarifa_promparam(codigo_empresa)),&
										  articulo,f_calidad_promparam(codigo_empresa)) * cantidad
IF IsNull(venta) Then venta = 0										  
coste   = coste  *  cantidad
peso    = peso   *  piezas
venta   = venta 
IF IsNull(coste) Then coste = 0
IF IsNull(venta) Then venta = 0
IF IsNull(peso) Then peso = 0
UPDATE promlindetallped
Set    coste  = :coste,
       venta = :venta,
		 peso   = :peso
FROM promlindetallped  
WHERE promlindetallped.empresa = :codigo_empresa 
AND   promlindetallped.anyo    = :var_anyo 
AND   promlindetallped.pedido  = :var_pedido 
AND   promlindetallped.linea   = :var_linea 
AND   promlindetallped.orden   = :var_orden;
IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
COMMIT;
end subroutine

public subroutine f_calculo_promlinped ();String codpanel,clase_panel,var_medidas,var_expositor,var_panel,var_tipo_panel
Dec{0} var_piezas
Dec    peso_panel,coste_panel,venta_panel,v_coste_manipulacion,&
       peso_material ,coste_material ,venta_material 
Select promlinped.panel,promlinped.clase_panel,promlinped.cantidad,
       promlinped.tipo,       promlinped.tipo_panel
Into   :codpanel,:clase_panel,:var_piezas,:var_panel,:var_tipo_panel
From   promlinped
Where  promlinped.empresa = :codigo_empresa
And    promlinped.anyo    = :var_anyo
And    promlinped.pedido  = :var_pedido
And    promlinped.linea   = :var_linea;
IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error sele promli",sqlca.sqlerrtext)
descripcion_panel.text = f_nombre_prompaneles(codigo_empresa,codpanel)
var_medidas = f_medida_prompaneles(codigo_empresa,codpanel)
IF var_panel = "2" Then
	peso_panel  = f_peso_promclasemedidas(codigo_empresa,clase_panel,var_medidas)
	coste_panel = f_preciocoste_promclasemedidas(codigo_empresa,clase_panel,var_medidas)
	venta_panel = f_precioventa_promclasemedidas(codigo_empresa,clase_panel,var_medidas)
   v_coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,var_medidas)
ELSE
	peso_panel  = f_pesopanel_promparam(codigo_empresa)
	coste_panel = f_costepanel_promparam(codigo_empresa)
	venta_panel = f_pventapanel_promparam(codigo_empresa)
   v_coste_manipulacion =0
END IF	
IF IsNull(peso_panel)           Then  peso_panel = 0
IF IsNull(peso_panel)           Then  coste_panel = 0
IF IsNull(venta_panel)          Then  venta_panel = 0
IF IsNull(v_coste_manipulacion) Then  v_coste_manipulacion = 0

Select  Sum(promlindetallped.peso),Sum(promlindetallped.coste),Sum(promlindetallped.venta) 
Into    :peso_material,:coste_material,:venta_material
From promlindetallped
Where   promlindetallped.empresa   =  :codigo_empresa
And     promlindetallped.anyo      =  :var_anyo
AND     promlindetallped.pedido    =  :var_pedido
AND     promlindetallped.linea     =  :var_linea;
IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
IF isNull(peso_material) then peso_material = 0
IF isNull(coste_material) then coste_material = 0
IF isNull(venta_material) then venta_material = 0


  UPDATE promlinped  
     SET peso_panel   = :peso_panel,
			coste_panel  = :coste_panel,
			venta_panel  = :venta_panel,
			coste_manipulacion  = :v_coste_manipulacion,
			peso_material   = :peso_material,
			coste_material  = :coste_material,
			venta_material  = :venta_material
   WHERE promlinped.empresa = :codigo_empresa
	AND   promlinped.anyo = :var_anyo
	AND   promlinped.pedido = :var_pedido
	AND   promlinped.linea = :var_linea;
	IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
	COMMIT;
pesop.text  = String(peso_panel,f_mascara_decimales(0))
costep.text = String(coste_panel,f_mascara_decimales(0))
ventap.text = String(venta_panel,f_mascara_decimales(0))
coste_manipulacion.text = String(v_coste_manipulacion,f_mascara_decimales(0))
pesom.text  = String(peso_material,f_mascara_decimales(0))
costem.text = String(coste_material,f_mascara_decimales(0))
ventam.text = String(venta_material,f_mascara_decimales(0))
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Recalculo datos pedidos promocion"
This.title=istr_parametros.s_titulo_ventana
dw_proceso.SetTransObject(SQLCA)
dw_proceso1.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)


end event

on w_recalcular_prompedidos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_proceso1=create dw_proceso1
this.cliente=create cliente
this.st_1a=create st_1a
this.descripcion_articulo=create descripcion_articulo
this.dw_proceso2=create dw_proceso2
this.dw_proceso=create dw_proceso
this.st_1b=create st_1b
this.descripcion_panel=create descripcion_panel
this.st_1c=create st_1c
this.st_1d=create st_1d
this.st_1e=create st_1e
this.st_1f=create st_1f
this.st_2c=create st_2c
this.st_2d=create st_2d
this.st_2e=create st_2e
this.gb_1=create gb_1
this.st_3c=create st_3c
this.st_3d=create st_3d
this.st_3e=create st_3e
this.st_4c=create st_4c
this.st_4d=create st_4d
this.st_4e=create st_4e
this.st_5c=create st_5c
this.st_5d=create st_5d
this.st_5e=create st_5e
this.st_31=create st_31
this.st_33=create st_33
this.st_34=create st_34
this.pedido=create pedido
this.pesot=create pesot
this.costet=create costet
this.ventat=create ventat
this.pesotm=create pesotm
this.costetm=create costetm
this.ventatm=create ventatm
this.ventatp=create ventatp
this.costetp=create costetp
this.pesotp=create pesotp
this.pesop=create pesop
this.costep=create costep
this.ventap=create ventap
this.coste_manipulacion=create coste_manipulacion
this.pesom=create pesom
this.costem=create costem
this.ventam=create ventam
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_proceso1
this.Control[iCurrent+5]=this.cliente
this.Control[iCurrent+6]=this.st_1a
this.Control[iCurrent+7]=this.descripcion_articulo
this.Control[iCurrent+8]=this.dw_proceso2
this.Control[iCurrent+9]=this.dw_proceso
this.Control[iCurrent+10]=this.st_1b
this.Control[iCurrent+11]=this.descripcion_panel
this.Control[iCurrent+12]=this.st_1c
this.Control[iCurrent+13]=this.st_1d
this.Control[iCurrent+14]=this.st_1e
this.Control[iCurrent+15]=this.st_1f
this.Control[iCurrent+16]=this.st_2c
this.Control[iCurrent+17]=this.st_2d
this.Control[iCurrent+18]=this.st_2e
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.st_3c
this.Control[iCurrent+21]=this.st_3d
this.Control[iCurrent+22]=this.st_3e
this.Control[iCurrent+23]=this.st_4c
this.Control[iCurrent+24]=this.st_4d
this.Control[iCurrent+25]=this.st_4e
this.Control[iCurrent+26]=this.st_5c
this.Control[iCurrent+27]=this.st_5d
this.Control[iCurrent+28]=this.st_5e
this.Control[iCurrent+29]=this.st_31
this.Control[iCurrent+30]=this.st_33
this.Control[iCurrent+31]=this.st_34
this.Control[iCurrent+32]=this.pedido
this.Control[iCurrent+33]=this.pesot
this.Control[iCurrent+34]=this.costet
this.Control[iCurrent+35]=this.ventat
this.Control[iCurrent+36]=this.pesotm
this.Control[iCurrent+37]=this.costetm
this.Control[iCurrent+38]=this.ventatm
this.Control[iCurrent+39]=this.ventatp
this.Control[iCurrent+40]=this.costetp
this.Control[iCurrent+41]=this.pesotp
this.Control[iCurrent+42]=this.pesop
this.Control[iCurrent+43]=this.costep
this.Control[iCurrent+44]=this.ventap
this.Control[iCurrent+45]=this.coste_manipulacion
this.Control[iCurrent+46]=this.pesom
this.Control[iCurrent+47]=this.costem
this.Control[iCurrent+48]=this.ventam
end on

on w_recalcular_prompedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_proceso1)
destroy(this.cliente)
destroy(this.st_1a)
destroy(this.descripcion_articulo)
destroy(this.dw_proceso2)
destroy(this.dw_proceso)
destroy(this.st_1b)
destroy(this.descripcion_panel)
destroy(this.st_1c)
destroy(this.st_1d)
destroy(this.st_1e)
destroy(this.st_1f)
destroy(this.st_2c)
destroy(this.st_2d)
destroy(this.st_2e)
destroy(this.gb_1)
destroy(this.st_3c)
destroy(this.st_3d)
destroy(this.st_3e)
destroy(this.st_4c)
destroy(this.st_4d)
destroy(this.st_4e)
destroy(this.st_5c)
destroy(this.st_5d)
destroy(this.st_5e)
destroy(this.st_31)
destroy(this.st_33)
destroy(this.st_34)
destroy(this.pedido)
destroy(this.pesot)
destroy(this.costet)
destroy(this.ventat)
destroy(this.pesotm)
destroy(this.costetm)
destroy(this.ventatm)
destroy(this.ventatp)
destroy(this.costetp)
destroy(this.pesotp)
destroy(this.pesop)
destroy(this.costep)
destroy(this.ventap)
destroy(this.coste_manipulacion)
destroy(this.pesom)
destroy(this.costem)
destroy(this.ventam)
end on

event activate;call super::activate;w_recalcular_prompedidos = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_recalcular_prompedidos
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_recalcular_prompedidos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_recalcular_prompedidos
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_recalcular_prompedidos
integer x = 2665
integer y = 4
integer width = 137
integer height = 120
integer taborder = 0
end type

type st_1 from statictext within w_recalcular_prompedidos
integer x = 69
integer y = 172
integer width = 256
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pedido"
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_recalcular_prompedidos
integer x = 2121
integer y = 168
integer height = 104
integer taborder = 0
string text = "Procesar"
end type

event clicked;call super::clicked;Dec r,r1,e1,e,w,w1


r1 = dw_proceso.Retrieve(codigo_empresa)
For r = 1 To r1
	var_anyo   = dw_proceso.GetItemNumber(r,"anyo")
	var_pedido = dw_proceso.GetItemNumber(r,"pedido")
	pedido.text = String(var_pedido,f_mascara_decimales(0))
	e1 = dw_proceso1.Retrieve(codigo_empresa,var_anyo,var_pedido)
	IF e1 <> 0 Then
		For e = 1 To e1
			var_linea = dw_proceso1.GetItemNumber(e,"linea")
			w1 = dw_proceso2.Retrieve(codigo_empresa,var_anyo,var_pedido,var_linea)
				IF w1 <> 0 Then
				For w = 1 To w1
					var_orden = dw_proceso2.GetItemNumber(w,"orden")
					f_calculo_promlindetallped()
				Next
				f_calculo_promlinped()
				END IF
		Next
		f_calculo_promped()
	End If
	f_contador_procesos(r,r1)
Next
end event

type dw_proceso1 from datawindow within w_recalcular_prompedidos
boolean visible = false
integer x = 960
integer width = 494
integer height = 176
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_promlinped"
boolean livescroll = true
end type

type cliente from statictext within w_recalcular_prompedidos
integer x = 754
integer y = 172
integer width = 1339
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1a from statictext within w_recalcular_prompedidos
integer x = 1399
integer y = 572
integer width = 256
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Articulo"
boolean focusrectangle = false
end type

type descripcion_articulo from statictext within w_recalcular_prompedidos
integer x = 1637
integer y = 572
integer width = 1038
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_proceso2 from datawindow within w_recalcular_prompedidos
boolean visible = false
integer x = 1627
integer y = 4
integer width = 494
integer height = 168
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_proceso_promlindetallped"
boolean livescroll = true
end type

type dw_proceso from datawindow within w_recalcular_prompedidos
boolean visible = false
integer x = 407
integer width = 494
integer height = 176
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_proceso_promped"
boolean livescroll = true
end type

type st_1b from statictext within w_recalcular_prompedidos
integer x = 64
integer y = 588
integer width = 256
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Panel:"
boolean focusrectangle = false
end type

type descripcion_panel from statictext within w_recalcular_prompedidos
integer x = 302
integer y = 588
integer width = 1038
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1c from statictext within w_recalcular_prompedidos
integer x = 297
integer y = 680
integer width = 174
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso:"
boolean focusrectangle = false
end type

type st_1d from statictext within w_recalcular_prompedidos
integer x = 709
integer y = 680
integer width = 192
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste:"
boolean focusrectangle = false
end type

type st_1e from statictext within w_recalcular_prompedidos
integer x = 1125
integer y = 680
integer width = 201
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Venta:"
boolean focusrectangle = false
end type

type st_1f from statictext within w_recalcular_prompedidos
integer x = 288
integer y = 768
integer width = 603
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste Manipulacion:"
boolean focusrectangle = false
end type

type st_2c from statictext within w_recalcular_prompedidos
integer x = 297
integer y = 1024
integer width = 174
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso:"
boolean focusrectangle = false
end type

type st_2d from statictext within w_recalcular_prompedidos
integer x = 709
integer y = 1024
integer width = 192
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste:"
boolean focusrectangle = false
end type

type st_2e from statictext within w_recalcular_prompedidos
integer x = 1125
integer y = 1024
integer width = 201
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Venta:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_recalcular_prompedidos
integer x = 270
integer y = 928
integer width = 1367
integer height = 244
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Material del panel"
end type

type st_3c from statictext within w_recalcular_prompedidos
integer x = 297
integer y = 280
integer width = 174
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso:"
boolean focusrectangle = false
end type

type st_3d from statictext within w_recalcular_prompedidos
integer x = 709
integer y = 280
integer width = 192
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste:"
boolean focusrectangle = false
end type

type st_3e from statictext within w_recalcular_prompedidos
integer x = 1125
integer y = 280
integer width = 201
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Venta:"
boolean focusrectangle = false
end type

type st_4c from statictext within w_recalcular_prompedidos
integer x = 297
integer y = 380
integer width = 174
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso:"
boolean focusrectangle = false
end type

type st_4d from statictext within w_recalcular_prompedidos
integer x = 709
integer y = 380
integer width = 192
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste:"
boolean focusrectangle = false
end type

type st_4e from statictext within w_recalcular_prompedidos
integer x = 1125
integer y = 380
integer width = 201
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Venta:"
boolean focusrectangle = false
end type

type st_5c from statictext within w_recalcular_prompedidos
integer x = 297
integer y = 480
integer width = 174
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Peso:"
boolean focusrectangle = false
end type

type st_5d from statictext within w_recalcular_prompedidos
integer x = 709
integer y = 480
integer width = 192
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Coste:"
boolean focusrectangle = false
end type

type st_5e from statictext within w_recalcular_prompedidos
integer x = 1125
integer y = 480
integer width = 201
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Venta:"
boolean focusrectangle = false
end type

type st_31 from statictext within w_recalcular_prompedidos
integer x = 105
integer y = 280
integer width = 174
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total"
boolean focusrectangle = false
end type

type st_33 from statictext within w_recalcular_prompedidos
integer x = 18
integer y = 380
integer width = 251
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Material"
boolean focusrectangle = false
end type

type st_34 from statictext within w_recalcular_prompedidos
integer x = 18
integer y = 480
integer width = 251
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Panel"
boolean focusrectangle = false
end type

type pedido from statictext within w_recalcular_prompedidos
integer x = 338
integer y = 164
integer width = 352
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pesot from statictext within w_recalcular_prompedidos
integer x = 471
integer y = 272
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type costet from statictext within w_recalcular_prompedidos
integer x = 891
integer y = 272
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ventat from statictext within w_recalcular_prompedidos
integer x = 1330
integer y = 272
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pesotm from statictext within w_recalcular_prompedidos
integer x = 471
integer y = 368
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type costetm from statictext within w_recalcular_prompedidos
integer x = 891
integer y = 368
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ventatm from statictext within w_recalcular_prompedidos
integer x = 1330
integer y = 368
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ventatp from statictext within w_recalcular_prompedidos
integer x = 1330
integer y = 468
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type costetp from statictext within w_recalcular_prompedidos
integer x = 891
integer y = 468
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pesotp from statictext within w_recalcular_prompedidos
integer x = 471
integer y = 468
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pesop from statictext within w_recalcular_prompedidos
integer x = 471
integer y = 672
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type costep from statictext within w_recalcular_prompedidos
integer x = 891
integer y = 672
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ventap from statictext within w_recalcular_prompedidos
integer x = 1330
integer y = 672
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type coste_manipulacion from statictext within w_recalcular_prompedidos
integer x = 891
integer y = 768
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pesom from statictext within w_recalcular_prompedidos
integer x = 475
integer y = 1016
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type costem from statictext within w_recalcular_prompedidos
integer x = 896
integer y = 1016
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ventam from statictext within w_recalcular_prompedidos
integer x = 1335
integer y = 1016
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

