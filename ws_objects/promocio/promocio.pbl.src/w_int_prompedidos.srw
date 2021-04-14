$PBExportHeader$w_int_prompedidos.srw
forward
global type w_int_prompedidos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_int_prompedidos
end type
type pb_salir from upb_salir within w_int_prompedidos
end type
type dw_report from datawindow within w_int_prompedidos
end type
type st_cliente from statictext within w_int_prompedidos
end type
type dw_lineas from datawindow within w_int_prompedidos
end type
type dw_proceso from datawindow within w_int_prompedidos
end type
type cb_imprimir from u_boton within w_int_prompedidos
end type
type cb_lineas from u_boton within w_int_prompedidos
end type
type cb_consulta from u_boton within w_int_prompedidos
end type
type cb_pallets from u_boton within w_int_prompedidos
end type
type dw_detalle from u_datawindow within w_int_prompedidos
end type
type uo_cliente from u_em_campo_2 within w_int_prompedidos
end type
type em_anyo from u_em_campo within w_int_prompedidos
end type
type ddlb_1 from dropdownlistbox within w_int_prompedidos
end type
type dw_proceso2 from datawindow within w_int_prompedidos
end type
type gb_1 from groupbox within w_int_prompedidos
end type
type uo_manejo from u_manejo_datawindow within w_int_prompedidos
end type
end forward

global type w_int_prompedidos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2953
integer height = 1704
event ue_listar pbm_custom12
pb_calculadora pb_calculadora
pb_salir pb_salir
dw_report dw_report
st_cliente st_cliente
dw_lineas dw_lineas
dw_proceso dw_proceso
cb_imprimir cb_imprimir
cb_lineas cb_lineas
cb_consulta cb_consulta
cb_pallets cb_pallets
dw_detalle dw_detalle
uo_cliente uo_cliente
em_anyo em_anyo
ddlb_1 ddlb_1
dw_proceso2 dw_proceso2
gb_1 gb_1
uo_manejo uo_manejo
end type
global w_int_prompedidos w_int_prompedidos

type variables
string antecliente, acceso,consulta // S-> Sí N-> No
String control_lineas,ant_cliente,ant_serie,ins_nueva_serie
end variables

forward prototypes
public subroutine f_control_tabulador ()
public function boolean f_existen_lineas ()
public subroutine f_detalle ()
public subroutine f_insertar_linea ()
public subroutine f_borrar_linea ()
public subroutine f_salir_detalle ()
public function boolean f_control_borrado ()
public function boolean f_grabar_nueva_serie ()
public function boolean f_grabar_paneles ()
public function boolean f_calculo_pedido ()
end prototypes

event ue_listar;call super::ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,uo_cliente.em_campo.text)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end event

public subroutine f_control_tabulador ();IF dw_1.GetRow() = 0 Then Return
IF dw_1.GetItemString(dw_1.GetRow(),"tipo_cliente") = "S" Then
	dw_1.SetTabOrder("envio",70)
	dw_1.SetTabOrder("correspondencia",80)
ELSE
	dw_1.SetTabOrder("envio",0)
	dw_1.SetTabOrder("correspondencia",0)
END IF
IF insercion= "S" Then 
	
	IF dw_1.GetRow() =  0   Then Return
	 
	dw_1.AcceptText()
	
	Dec{0}  var_coste_expositor,var_venta_expositor,var_coste_total,&
			  var_venta_total,registros,var_anyo,var_pedido,&
			  var_coste_manipulacion
	Dec{2}  var_peso_expositor,var_peso_total,var_peso_material
	var_anyo   = Dec(em_anyo.text)
	var_pedido = Dec(sle_valor.text)
			
	dw_1.SetTabOrder("tipo",100)
	
	IF dw_1.GetItemString(dw_1.GetRow(),"tipo") = "1" Then
		 var_peso_expositor  = 0
		 var_coste_expositor = 0
		 var_venta_expositor = 0
		 dw_1.SetTabOrder("expositor",0)
		 dw_1.SetTabOrder("tipo_expositor",0)
		 dw_1.SetTabOrder("reposicion",0)
		 dw_1.SetTabOrder("clase_panel",0)
		 dw_1.SetItem(dw_1.GetRow(),"expositor","")				  
		 dw_1.SetItem(dw_1.GetRow(),"tipo_expositor","")				  
		 dw_1.SetItem(dw_1.GetRow(),"reposicion","N")
		 dw_1.SetItem(dw_1.GetRow(),"clase_panel","")
	ELSE
		IF dw_1.GetItemString(dw_1.GetRow(),"reposicion") = "S" Then
			 var_peso_expositor  = 0
			 var_coste_expositor = 0
			 var_venta_expositor = 0
			 dw_1.SetTabOrder("numserie",160)
			 dw_1.SetTabOrder("reposicion",110)
			 dw_1.SetTabOrder("clase_panel",120)
			 dw_1.SetTabOrder("expositor",0)
			 dw_1.SetTabOrder("tipo_expositor",0)
			 dw_1.SetItem(dw_1.GetRow(),"tipo_expositor",f_tipo_expositor_promseries(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"numserie")))
			 dw_1.SetItem(dw_1.GetRow(),"expositor",f_expositor_promseries(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"numserie")))
		ELSE
			 var_peso_expositor  = f_peso_promcabexpositores(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"expositor"))
			 var_coste_expositor = f_coste_promexpositores(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor"))
			 var_venta_expositor = f_pventa_promexpositores(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor"))
			 var_peso_material   = f_pesomaterial_promcabexpositores(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"expositor"))
			 dw_1.SetTabOrder("numserie",0)
			 dw_1.SetTabOrder("expositor",140)
			 dw_1.SetTabOrder("tipo_expositor",130)
			 dw_1.SetTabOrder("reposicion",110)
			 dw_1.SetTabOrder("clase_panel",120)
		END IF
		IF Len(f_valor_columna(dw_1,dw_1.GetRow(),"clase_panel"))= 0 Then
			 dw_1.setitem(dw_1.getrow(),"clase_panel",f_clase_panel_promparam(codigo_empresa))
		END IF
	END IF				
	
	IF IsNull(var_peso_expositor)  Then  var_peso_expositor  = 0
	IF IsNull(var_coste_expositor) Then  var_coste_expositor = 0
	IF IsNull(var_venta_expositor) Then  var_venta_expositor = 0
	
	dw_1.SetItem(dw_1.GetRow(),"peso_expositor",var_peso_expositor)
	dw_1.SetItem(dw_1.GetRow(),"coste_expositor",var_coste_expositor)
	dw_1.SetItem(dw_1.GetRow(),"venta_expositor",var_venta_expositor)
	dw_1.SetItem(dw_1.GetRow(),"peso_material",var_peso_material)
	var_peso_total  = var_peso_expositor + var_peso_material
	var_coste_total = var_coste_expositor
	var_venta_total = var_venta_expositor
	dw_1.SetItem(dw_1.GetRow(),"peso_total"  , var_peso_total)
	dw_1.SetItem(dw_1.GetRow(),"coste_total" , var_coste_total)
	dw_1.SetItem(dw_1.GetRow(),"venta_total" , var_venta_total)
END IF			

IF insercion<> "S" Then 
	  dw_1.SetTabOrder("reposicion",0)
	  dw_1.SetTabOrder("numserie",0)
	  dw_1.SetTabOrder("expositor",0)
	  dw_1.SetTabOrder("tipo_expositor",0)
	  dw_1.SetTabOrder("tipo",0)
END IF
			  
end subroutine

public function boolean f_existen_lineas ();dec{0} anyo,pedido,registros
anyo    = Dec(em_anyo.text)
pedido  = Dec(sle_valor.text)
registros = 0
Select  count(*) Into :registros From promlinped
Where   promlinped.empresa   = :codigo_empresa
And     promlinped.anyo      = :anyo
And     promlinped.pedido    = :pedido;
If IsNull(registros) Then registros = 0
If registros <> 0 then
	
	Return True
Else
	Return false
 
END IF


end function

public subroutine f_detalle ();Dec{0}  var_anyo,var_pedido


var_anyo = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)
dw_detalle.visible= TRUE
f_mascara_columna(dw_detalle,"fila","###,###")
f_mascara_columna(dw_detalle,"altura","###,###")
f_mascara_columna(dw_detalle,"pallets","###,###")
dw_detalle.SetTransObject(SQLCA)
dw_detalle.Retrieve(codigo_empresa,var_anyo,var_pedido)
If dw_detalle.RowCount() =0 Then f_insertar_linea()

cb_borrar.enabled    = FALSE
cb_consulta.enabled  = FALSE
cb_imprimir.enabled  = FALSE
cb_insertar.enabled  = FALSE
cb_lineas.enabled    = FALSE
cb_pallets.enabled   = FALSE
cb_salir.enabled     = FALSE
dw_1.enabled         = FALSE
em_anyo.enabled      = FALSE
sle_valor.enabled    = FALSE




end subroutine

public subroutine f_insertar_linea ();Integer reg
String  var_tipo_pallet,var_almacen,var_zona
Dec{2}  var_pallets
Dec{0}  var_orden,var_pedido,var_anyo,var_fila,var_altura,registro,registros
dw_detalle.Accepttext()

registros = dw_detalle.RowCount()
If registros <> 0 then
For registro = 1 to registros
   var_fila        = dw_detalle.GetItemNumber(registro,"fila")
   var_altura      = dw_detalle.GetItemNumber(registro,"altura")
   var_pallets    = dw_detalle.GetItemNumber(registro,"pallets")
	var_tipo_pallet = dw_detalle.GetItemString(registro,"tipo_pallets")
	var_zona = dw_detalle.GetItemString(registro,"zona")
	var_almacen = dw_detalle.GetItemString(registro,"almacen")
	If IsNull(var_altura) Then var_altura= 0
	If var_fila= 0 or IsNull(var_fila) Then
		f_mensaje("Campo Obligatorio","Introduzca la fila")
		dw_detalle.SetColumn("fila")
		return
	END IF
	If var_pallets= 0  or IsNull(var_pallets) Then
		f_mensaje("Campo Obligatorio","Introduzca la cantidad de pallets")
		dw_detalle.SetColumn("pallets")
		return
	END IF
		If Trim(var_tipo_pallet)= ""  or IsNull(var_tipo_pallet) Then
		f_mensaje("Campo Obligatorio","Introduzca el tipo de pallet")
		dw_detalle.SetColumn("tipo_pallets")
		return
	END IF
	IF Not f_ubi_exist(codigo_empresa,var_almacen,var_zona,var_fila,var_altura) Then
		f_mensaje("No se puede grabar  la linea"," La Ubicacion no esta contemplada en mapa de ubicaciones")
		dw_detalle.SetColumn("fila")
		return
	END IF
Next
END IF 

dw_detalle.Update()
COMMIT;


reg = dw_detalle.RowCount()
reg = reg + 1
var_anyo   = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)
dw_detalle.InsertRow(reg)
dw_detalle.SetItem(reg,"empresa",codigo_empresa)
dw_detalle.SetItem(reg,"almacen",f_almacen_venparametros(codigo_empresa))
dw_detalle.SetItem(reg,"zona",f_zona_venparametros(codigo_empresa))
dw_detalle.SetItem(reg,"tipo_pallets","1")
dw_detalle.SetItem(reg,"control_libre","")
dw_detalle.SetItem(reg,"situacion","P")
Select Max(orden) Into :var_orden From prompedexp
Where  prompedexp.empresa = :codigo_empresa
And    prompedexp.anyo    = :var_anyo
And    prompedexp.pedido  = :var_pedido;
IF IsNull(var_orden) Then var_orden = 0
var_orden  =  var_orden + 1
dw_detalle.SetItem(reg,"anyo",var_anyo)
dw_detalle.SetItem(reg,"pedido",var_pedido)
dw_detalle.SetItem(reg,"orden",var_orden)
dw_detalle.ScrollToRow(reg)
dw_detalle.SetRow(reg)
dw_detalle.SetColumn("fila")
dw_detalle.SetFocus()

end subroutine

public subroutine f_borrar_linea ();If dw_detalle.GetRow() = 0 Then Return
 IF dw_detalle.GetItemString(dw_detalle.GetRow(),"situacion") = "S" Then
	f_mensaje("No se puede borrar la linea"," La linea esta servida")
	Return
 END IF
 dw_detalle.deleteRow(dw_detalle.GetRow())

end subroutine

public subroutine f_salir_detalle ();cb_borrar.enabled    = TRUE
cb_consulta.enabled  = TRUE
cb_imprimir.enabled  = TRUE
//cb_insertar.enabled  = TRUE
cb_lineas.enabled    = TRUE
cb_pallets.enabled   = TRUE
cb_salir.enabled     = TRUE
dw_1.enabled         = TRUE
em_anyo.enabled      = TRUE
sle_valor.enabled    = TRUE
dw_detalle.visible= FALSE
pb_salir.enabled = TRUE
f_activar_campo(sle_valor)
end subroutine

public function boolean f_control_borrado ();Integer  var_anyo,var_pedido,bien


COMMIT;
										 

var_anyo   = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)

bien = 0
DELETE FROM prompedreposicion 
WHERE (prompedreposicion.empresa = :codigo_empresa)                       
AND   (prompedreposicion.anyo = :var_anyo )
AND   (prompedreposicion.pedido = :var_pedido );

IF SQLCA.SQLCode <> 0 Then bien =1

DELETE FROM prompedlinreposicion
WHERE (prompedlinreposicion.empresa = :codigo_empresa)                       
AND   (prompedlinreposicion.anyo = :var_anyo )
AND   (prompedlinreposicion.pedido = :var_pedido );

IF SQLCA.SQLCode <> 0 Then bien =1													 
						 
DELETE FROM prompedexp
WHERE (prompedexp.empresa = :codigo_empresa)                       
AND   (prompedexp.anyo = :var_anyo )
AND    (prompedexp.pedido = :var_pedido );

IF SQLCA.SQLCode <> 0 Then bien =1
									
Delete from promlinped
Where  promlinped.empresa = :codigo_empresa
And    promlinped.anyo    = :var_anyo
And    promlinped.pedido  = :var_pedido;

If Sqlca.SqlCode<>0 Then bien = 1

Delete from promlindetallped
Where  promlindetallped.empresa = :codigo_empresa
And    promlindetallped.anyo    = :var_anyo
And    promlindetallped.pedido  = :var_pedido;

If Sqlca.SqlCode<>0 Then bien = 1

string nserie

nserie = dw_1.GetItemString(dw_1.GetRow(),"numserie")
IF dw_1.GetItemString(dw_1.GetRow(),"reposicion")= "N" Then
		UPdate promseries
		Set    cliente = null,
				 nombre  = null,
				 domicilio = null,
				 codpostal = null,
				 provincia = null,
				 pais      = null,
				 poblacion = null,
				 fpedido   = null,
				 anyo      = null,
				 pedido    = null,
				 situacion = "S"
		Where  promseries.empresa  = :codigo_empresa
		And    promseries.codigo   = :nserie;
		If Sqlca.SqlCode<>0 Then bien = 1
END IF
If bien <> 0 Then
	ROLLBACK;
	f_mensaje("Error en borrado de datos"," La operacion no se actualiza")
	Return FALSE
End IF
Return True
end function

public function boolean f_grabar_nueva_serie ();Integer registros,bien
string var_pais,var_provincia,var_codpostal,var_poblacion,var_domicilio 
string var_cliente,var_envio,var_numserie,var_nombre,var_numserie_ant
string var_tipo_expositor,var_tipo_panel
long var_anyo,var_pedido
datetime var_fpedido

bien = 0

Select count(*) Into :registros From promseries
Where  promseries.empresa = :codigo_empresa;

IF registros = 0  Then
	var_numserie = "1"
ELSE
	Select max(convert(int,promseries.codigo)+1)
	Into   :var_numserie	
	From   promseries
	Where  promseries.empresa = :codigo_empresa;
END IF
messagebox("Atención","Creando y asignando la serie["+var_numserie+"]")
var_anyo     			= Dw_1.GetItemNumber(Dw_1.GetRow(),"anyo")
var_pedido   			= Dw_1.GetItemNumber(Dw_1.GetRow(),"pedido")
var_cliente  			= Dw_1.GetItemString(Dw_1.GetRow(),"cliente")
var_tipo_expositor	= Dw_1.GetItemString(Dw_1.GetRow(),"tipo_expositor")
var_fpedido  			= Dw_1.GetItemDateTime(Dw_1.GetRow(),"fpedido")
var_envio    			= Dw_1.GetItemString(Dw_1.GetRow(),"envio")
var_tipo_panel       = f_tipo_panel_mueble(codigo_empresa,var_tipo_expositor)

if isnull(var_envio) then
	var_envio = ""
ELSE
	SELECT venenvio.pais,     venenvio.provincia,    venenvio.codpostal,   
	venenvio.localidad,venenvio.domicilio  
	INTO :var_pais,:var_provincia,:var_codpostal,:var_poblacion,:var_domicilio 
	FROM venenvio  
	WHERE (venenvio.empresa = :codigo_empresa )
	AND   (venenvio.cliente = :var_cliente )
	AND   (venenvio.codigo = :var_envio );
	
	IF sqlca.sqlcode = 100 Then	var_envio = ""
	
	iF IsNull(var_envio) Then var_envio = ""
	
END IF
IF var_envio = "" Then
	SELECT genter.razon,genter.pais,genter.provincia,genter.cod_postal,   
	genter.domicilio,genter.localidad  
	INTO :var_nombre,:var_pais,:var_provincia,:var_codpostal,   
	:var_domicilio,:var_poblacion  
	FROM genter  
	WHERE (genter.empresa = :codigo_empresa ) AND  
	(genter.tipoter = 'C' ) AND  
	(genter.codigo  = :var_cliente);
ELSE
	var_nombre = f_razon_genter(codigo_empresa,"C",var_cliente)
END IF

Select numserie Into :var_numserie_ant From promped
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    pedido  = :var_pedido;

IF Not IsNull(var_numserie_ant) And var_numserie_ant <> "" Then

	UPdate  promseries
	Set    situacion  = "S",
	cliente    = null,
	anyo       = null,
	pedido     = null,
	fpedido    = null,
	nombre     = null,
	domicilio  = null,
	codpostal  = null,
	provincia  = null,
	pais       = null,
	poblacion  = null
	Where   empresa = :codigo_empresa
	And     codigo  = :var_numserie_ant;
	
	IF SQLCA.SQLCODE <> 0 Then bien = 1

END IF

Update  promped
Set    numserie = :var_numserie
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    pedido  = :var_pedido;

IF SQLCA.SQLCODE <> 0 Then bien = 1

Update  promlinped
Set    numserie = :var_numserie
Where  empresa = :codigo_empresa
And    anyo    = :var_anyo
And    pedido  = :var_pedido;

IF SQLCA.SQLCODE <> 0 Then bien = 1

insert into promseries
				(empresa,
				codigo,
				cliente,
				nombre,
				domicilio,
				codpostal,
				provincia,
				pais,
				poblacion,
				tipo_expositor,
				situacion,				
				fpedido,
				anyo,
				pedido,
				clase_panel)				
				values
				(:codigo_empresa,
				:var_numserie,				
				:var_cliente,
				:var_nombre,
				:var_domicilio,
				:var_codpostal,
				:var_provincia,
				:var_pais,
				:var_poblacion,
				:var_tipo_expositor,
				"R",
				:var_fpedido,				
				:var_anyo,
				:var_pedido,
				:var_tipo_panel);				
								
IF SQLCA.SQLCODE <> 0 Then bien = 1

if bien = 1 then
	ins_nueva_serie = ""
	return false
else	
	Dw_1.object.numserie[Dw_1.GetRow()] = var_numserie
	ins_nueva_serie = var_numserie
	return true
end if
end function

public function boolean f_grabar_paneles ();String medida,var_serie
Integer registro,registros,bien,registro2,registros2
str_promlinped linped
str_promlindetallped detalle

bien =0
   registros = dw_proceso.Retrieve(codigo_empresa,dw_1.GetItemString(dw_1.GetRow(),"expositor"))
	linped.empresa =  codigo_empresa
	linped.anyo = Dec(em_anyo.text)
	linped.pedido=Dec(sle_valor.text)
	linped.cliente = dw_1.GetItemString(dw_1.GetRow(),"cliente")
	linped.pais= dw_1.GetItemString(dw_1.GetRow(),"pais")
	linped.tipo= dw_1.GetItemString(dw_1.GetRow(),"tipo_cliente")
	linped.f_pedido       = dw_1.GetItemDateTime(dw_1.GetRow(),"fpedido")
   linped.f_entrega      = dw_1.GetItemDateTime(dw_1.GetRow(),"fentrega")
	linped.agente1        = dw_1.GetItemString(dw_1.GetRow(),"agente1")
	linped.agente2        = dw_1.GetItemString(dw_1.GetRow(),"agente2")
	linped.agente3        = dw_1.GetItemString(dw_1.GetRow(),"agente3")
	linped.tipo_expositor = dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")
	linped.expositor      = dw_1.GetItemString(dw_1.GetRow(),"expositor")
	linped.usuario        = dw_1.GetItemString(dw_1.GetRow(),"usuario")
	linped.usuario_pedido = dw_1.GetItemString(dw_1.GetRow(),"usuario_pedido")
	linped.reposicion     = dw_1.GetItemString(dw_1.GetRow(),"reposicion")
	linped.control_libre  = ""
	linped.clase_panel    = dw_1.GetItemString(dw_1.GetRow(),"clase_panel")
	var_serie             = dw_1.GetItemString(dw_1.GetRow(),"numserie")
	
If registros > 0 Then 
	For registro = 1 To registros
		linped.linea          = registro
		linped.panel          = dw_proceso.GetItemString(registro,"panel")
		linped.cantidad= 1
 		linped.peso_material  = dw_proceso.GetItemNumber(registro,"pesomaterial")
		linped.coste_material = dw_proceso.GetItemNumber(registro,"costematerial")
		linped.venta_material = dw_proceso.GetItemNumber(registro,"ventamaterial")
		linped.situacion      = "C"
		linped.tipo_panel     = dw_proceso.GetItemString(registro,"tipo")
		linped.coste_material = dw_proceso.GetItemNumber(registro,"costematerial")
		linped.peso_material  = dw_proceso.GetItemNumber(registro,"pesomaterial")
		linped.venta_material = dw_proceso.GetItemNumber(registro,"ventamaterial")
	   medida                = f_medida_promlinexpositores (codigo_empresa,linped.tipo_expositor,linped.tipo_panel)
      linped.coste_panel    = f_preciocoste_promclasemedidas(codigo_empresa,linped.clase_panel,medida)
      linped.peso_panel     = f_peso_promclasemedidas(codigo_empresa,linped.clase_panel,medida)
      linped.coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,medida)
      linped.venta_panel    = f_precioventa_promclasemedidas(codigo_empresa,linped.clase_panel,medida)
		
		if isnull(ins_nueva_serie) or trim(ins_nueva_serie) = "" then
			linped.numserie = var_serie//f_numserie_promped(linped.empresa,linped.anyo,linped.pedido)
		else
      	linped.numserie =	ins_nueva_serie
		end if

		  INSERT INTO promlinped  
         ( empresa,
			anyo,
			pedido,
			linea,
			cliente,
			pais,
			tipo,
			reposicion,   
           panel,   
           cantidad,   
           peso_panel,   
           coste_panel,   
           venta_panel,   
           peso_material,   
           coste_material,   
           venta_material,
			  usuario,
			  usuario_pedido,
			  situacion,
		 	  control_libre,
		  	  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor,
			  clase_panel,
			  tipo_panel,
			  coste_manipulacion,
			  numserie,
			  cambio_composicion) 
  VALUES ( :linped.empresa,   
           :linped.anyo,   
           :linped.pedido,   
           :linped.linea,   
           :linped.cliente,   
           :linped.pais,   
           :linped.tipo,   
           :linped.reposicion,   
           :linped.panel,   
           :linped.cantidad,   
           :linped.peso_panel,   
           :linped.coste_panel,   
           :linped.venta_panel,   
           :linped.peso_material,   
           :linped.coste_material,   
           :linped.venta_material,
			  :linped.usuario,
			  :linped.usuario_pedido,
 			  :linped.situacion,
			  :linped.control_libre,
		  	  :linped.f_pedido,
			  :linped.f_entrega,
			  :linped.agente1,
			  :linped.agente2,
			  :linped.agente3,
			  :linped.tipo_expositor,
			  :linped.expositor,
			  :linped.clase_panel,
  			  :linped.tipo_panel,
			  :linped.coste_manipulacion,
  			  :linped.numserie,
  			  "N");
  	 		  IF sqlca.Sqlcode<> 0 Then 
					bien = 1
  			  END IF
	  registros2 =  dw_proceso2.Retrieve(codigo_empresa,linped.panel)
	  IF registros2 <> 0 THEN
		FOR registro2 = 1 To registros2
			detalle.empresa = codigo_empresa
			detalle.anyo    = linped.anyo
			detalle.pedido  = linped.pedido
			detalle.linea   = linped.linea
			detalle.orden   = registro2
			detalle.panel   = linped.panel
			detalle.articulo = dw_proceso2.GetItemString(registro2,"articulo")
			detalle.calidad  = dw_proceso2.GetItemString(registro2,"calidad")
			detalle.montajeartcal  = dw_proceso2.GetItemString(registro2,"montajeartcal")
			detalle.piezas         = dw_proceso2.GetItemDecimal(registro2,"piezas")
			detalle.usuario        = linped.usuario
			detalle.usuario_pedido = linped.usuario_pedido
			detalle.observaciones=""
			detalle.peso= dw_proceso2.GetItemDecimal(registro2,"peso")
			detalle.coste= dw_proceso2.GetItemDecimal(registro2,"coste")
			detalle.venta= dw_proceso2.GetItemDecimal(registro2,"pventa")
			detalle.pais     = linped.pais
			detalle.cliente  = linped.cliente
			detalle.tipo  = linped.tipo
			detalle.reposicion  = linped.reposicion
			detalle.situacion   = linped.situacion
			detalle.f_pedido    = linped.f_pedido
			detalle.f_entrega   = linped.f_entrega
			detalle.agente1  = linped.agente1
			detalle.agente2  = linped.agente2
			detalle.agente3  = linped.agente3
			detalle.tipo_expositor  = linped.tipo_expositor
			detalle.expositor       = linped.expositor
			  INSERT INTO promlindetallped  
         ( empresa,   
           anyo,   
           pedido,   
           linea,   
           orden,   
           panel,   
           articulo,   
           calidad,   
           montajeartcal,   
           piezas,   
           usuario,   
           usuario_pedido,   
           observaciones,   
           peso,   
           coste,   
           venta,   
           pais,   
           cliente,
			  tipo,
			  reposicion,
			  situacion,
			  f_pedido,
			  f_entrega,
			  agente1,
			  agente2,
			  agente3,
			  tipo_expositor,
			  expositor)  
  VALUES ( :detalle.empresa,   
           :detalle.anyo,   
           :detalle.pedido,   
           :detalle.linea,   
           :detalle.orden,   
           :detalle.panel,   
           :detalle.articulo,   
           :detalle.calidad,   
           :detalle.montajeartcal,   
           :detalle.piezas,   
           :detalle.usuario,   
           :detalle.usuario_pedido,   
           :detalle.observaciones,   
           :detalle.peso,   
           :detalle.coste,   
           :detalle.venta,   
           :detalle.pais,   
           :detalle.cliente,
  			  :detalle.tipo,
  			  :detalle.reposicion,
			  :detalle.situacion,
			  :detalle.f_pedido,
			  :detalle.f_entrega,
			  :detalle.agente1,
			  :detalle.agente2,
			  :detalle.agente3,
			  :detalle.tipo_expositor,
			  :detalle.expositor);

			  IF sqlca.Sqlcode<> 0 Then 
				f_mensaje("Error en base de datos",SQLCA.SQLERRTEXT)
					bien = 1
					Exit
  			  END IF
			
			
		NEXT
		
	end if		
	
	Next
END IF
		
If bien = 0 then
	  return true
ELSE
	  f_mensaje("Error en proceso de datos"," No se pudo grabar el detalle del expositor")
	  return false
END IF
end function

public function boolean f_calculo_pedido ();Dec{2} var_coste_panel,var_venta_panel,var_peso_panel,var_coste_manipulacion,var_peso_material
Dec{2} var_coste_material,var_venta_material,var_anyo,var_pedido

var_anyo   = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)
			
Select Sum(peso_material*cantidad),sum(coste_material*cantidad),sum(venta_material*cantidad) ,
		 Sum(peso_panel*cantidad)  , sum(coste_panel * cantidad),
		 sum(venta_panel*cantidad) , sum(coste_manipulacion * cantidad) 
Into   :var_peso_material,:var_coste_material,:var_venta_material,
	    :var_peso_panel,:var_coste_panel,:var_venta_panel,
		 :var_coste_manipulacion
From   promlinped
WHERE ( promlinped.empresa = :codigo_empresa ) AND  
		( promlinped.anyo    = :var_anyo ) AND  
		( promlinped.pedido  = :var_pedido );

IF IsNull(var_peso_material)      Then var_peso_material   = 0
IF IsNull(var_coste_panel)        Then var_coste_panel     = 0
IF IsNull(var_venta_material)     Then var_venta_material  = 0
IF IsNull(var_peso_panel)         Then var_peso_panel      = 0
IF IsNull(var_coste_material)     Then var_coste_material  = 0
IF IsNull(var_venta_panel)        Then var_venta_panel     = 0
IF IsNull(var_coste_manipulacion) Then var_coste_manipulacion  = 0
		

UPDATE promped  
SET promped.peso_material       = :var_peso_material,   
	 promped.coste_material      = :var_coste_material,   
	 promped.venta_material      = :var_venta_material,
	 promped.peso_paneles        = :var_peso_panel,   
    promped.coste_paneles       = :var_coste_panel,   
	 promped.venta_paneles       = :var_venta_panel,
	 promped.coste_manipulacion  = :var_coste_manipulacion,
	 promped.peso_total  = :var_peso_material + :var_peso_panel  + promped.peso_expositor ,
	 promped.coste_total = :var_coste_material+ :var_coste_panel + promped.coste_expositor + :var_coste_manipulacion,   
	 promped.venta_total = :var_venta_material+ :var_venta_panel + promped.venta_expositor   + :var_coste_manipulacion,
	 promped.observaciones       = "Pruebas"
WHERE ( promped.empresa  = :codigo_empresa ) AND  
	   ( promped.anyo     = :var_anyo ) AND  
	   ( promped.pedido   = :var_pedido );
	
if sqlca.sqlcode <> 0 then
    messagebox("Error","Actualizando promped")	
    return false
else
	 return true
end if

end function

event ue_cursor_abajo;call super::ue_cursor_abajo;IF consulta = "S" Then f_cursor_abajo(dw_lineas)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "promped"
 dw_1.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(sle_valor.text))
 f_control_tabulador()

 cb_pallets.enabled  = TRUE
 
 dw_1.SetTabOrder("cliente",10)
 if dw_1.Rowcount()<>0 then
   ant_cliente = dw_1.GetItemString(dw_1.GetRow(),"cliente")
	ant_serie   = dw_1.GetItemString(dw_1.GetRow(),"serie")
	ins_nueva_serie = ""
 End if
 CALL Super::ue_recuperar




end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"anyo",Integer(em_anyo.text))
dw_1.setitem(dw_1.getrow(),"pedido",Dec(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"falta",Datetime(Today()))
dw_1.setitem(dw_1.getrow(),"fpedido",Datetime(Today()))
dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"usuario_pedido",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"tipo","1")
dw_1.setitem(dw_1.getrow(),"reposicion","N")

dw_1.setitem(dw_1.getrow(),"peso_expositor",0)
dw_1.setitem(dw_1.getrow(),"coste_expositor",0)
dw_1.setitem(dw_1.getrow(),"venta_expositor",0)

dw_1.setitem(dw_1.getrow(),"peso_paneles",0)
dw_1.setitem(dw_1.getrow(),"coste_paneles",0)
dw_1.setitem(dw_1.getrow(),"venta_paneles",0)

dw_1.setitem(dw_1.getrow(),"peso_material",0)
dw_1.setitem(dw_1.getrow(),"coste_material",0)
dw_1.setitem(dw_1.getrow(),"venta_material",0)

dw_1.setitem(dw_1.getrow(),"situacion","C")
dw_1.setitem(dw_1.getrow(),"control_libre","")
dw_1.setitem(dw_1.getrow(),"exp_cargado","N")
dw_1.setitem(dw_1.getrow(),"tipo_cliente","S")


cb_pallets.enabled = FALSE




end event

event ue_activa_claves;call super::ue_activa_claves;
// Activamos los campos clave añadidos

sle_valor.enabled      = TRUE
em_anyo.enabled        = TRUE
pb_calculadora.visible = TRUE
cb_lineas.enabled      = TRUE
cb_consulta.enabled    = TRUE
cb_lineas.enabled      = TRUE
cb_consulta.enabled    = TRUE
cb_imprimir.enabled    = TRUE
cb_pallets.enabled     = TRUE
end event

event open;call super::open;// Se controla el nivel de acceso del usuario
   acceso = f_control_acceso(nombre_usuario)

control_lineas= "N"
pb_calculadora.visible=FALSE
istr_parametros.s_titulo_ventana =   "Introducción de pedidos promoción"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana
em_anyo.text                     =   String(Year(Today()))
dw_lineas.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)

dw_lineas.SetRowFocusIndicator(Hand!)
consulta = "N"
f_activar_campo(sle_valor)
cb_pallets.enabled = FALSE

ddlb_1.text = "Si"
end event

on ue_f6;call wi_mvent_con_empresa::ue_f6;IF cb_imprimir.visible =FALSE Then Return
cb_imprimir.TriggerEvent(Clicked!)
end on

on ue_f4;call wi_mvent_con_empresa::ue_f4;IF cb_consulta.visible =FALSE Then Return
cb_consulta.TriggerEvent(Clicked!)

end on

event ue_desactiva_claves;call super::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled      = FALSE
em_anyo.enabled        = FALSE
pb_calculadora.visible = FALSE
cb_lineas.enabled      = FALSE
cb_consulta.enabled    = FALSE
cb_lineas.enabled      = FALSE
cb_consulta.enabled    = FALSE
cb_imprimir.enabled    = FALSE
cb_pallets.enabled     = FALSE

end event

on w_int_prompedidos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.pb_salir=create pb_salir
this.dw_report=create dw_report
this.st_cliente=create st_cliente
this.dw_lineas=create dw_lineas
this.dw_proceso=create dw_proceso
this.cb_imprimir=create cb_imprimir
this.cb_lineas=create cb_lineas
this.cb_consulta=create cb_consulta
this.cb_pallets=create cb_pallets
this.dw_detalle=create dw_detalle
this.uo_cliente=create uo_cliente
this.em_anyo=create em_anyo
this.ddlb_1=create ddlb_1
this.dw_proceso2=create dw_proceso2
this.gb_1=create gb_1
this.uo_manejo=create uo_manejo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.pb_salir
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.st_cliente
this.Control[iCurrent+5]=this.dw_lineas
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.cb_imprimir
this.Control[iCurrent+8]=this.cb_lineas
this.Control[iCurrent+9]=this.cb_consulta
this.Control[iCurrent+10]=this.cb_pallets
this.Control[iCurrent+11]=this.dw_detalle
this.Control[iCurrent+12]=this.uo_cliente
this.Control[iCurrent+13]=this.em_anyo
this.Control[iCurrent+14]=this.ddlb_1
this.Control[iCurrent+15]=this.dw_proceso2
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.uo_manejo
end on

on w_int_prompedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.pb_salir)
destroy(this.dw_report)
destroy(this.st_cliente)
destroy(this.dw_lineas)
destroy(this.dw_proceso)
destroy(this.cb_imprimir)
destroy(this.cb_lineas)
destroy(this.cb_consulta)
destroy(this.cb_pallets)
destroy(this.dw_detalle)
destroy(this.uo_cliente)
destroy(this.em_anyo)
destroy(this.ddlb_1)
destroy(this.dw_proceso2)
destroy(this.gb_1)
destroy(this.uo_manejo)
end on

on ue_pagina_arriba;call wi_mvent_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_pagina_abajo;call wi_mvent_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;IF consulta = "S" Then f_cursor_arriba(dw_lineas)
end event

event ue_borra_fila;f_control_borrado()
Call Super::ue_borra_fila
end event

event ue_f7;call super::ue_f7;IF cb_imprimir.visible =FALSE Then Return
cb_pallets.TriggerEvent(Clicked!)
end event

event ue_f5;call super::ue_f5;IF cb_lineas.visible =FALSE Then Return
cb_lineas.TriggerEvent(Clicked!)
end event

event activate;call super::activate;this.visible = true
w_int_prompedidos = ventanas_activas[id_ventana_activa].ventana
end event

event ue_actualiza_dw;Integer  veces,anyo,pedido
String   pais,cliente,agente1,agente2,agente3,tipo_expositor,v_expositor
DateTime f_pedido,f_entrega
string   repo,tipoexpo,nserie,tipoexpositor,tipocli,var_codcli
String   var_pais,var_provincia,var_codpostal,var_poblacion,var_domicilio 
String   venenvio,var_nombre,expositor
int bien = 0

dw_1.AcceptText()

var_codcli    = dw_1.GetItemString(dw_1.GetRow(),"cliente")
tipoexpo      = dw_1.GetItemString(dw_1.GetRow(),"tipo")
repo          = dw_1.GetItemString(dw_1.GetRow(),"reposicion")   
nserie        = dw_1.GetItemString(dw_1.GetRow(),"numserie")
tipoexpositor = dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")
v_expositor   = dw_1.GetItemString(dw_1.GetRow(),"expositor")

// Comprueba si se ha cambiado el cliente y tenia asignado nº de serie

if ant_cliente <> var_codcli and Trim(nserie) <> "" then
	venenvio = dw_1.GetItemString(dw_1.GetRow(),"envio")
	if venenvio<>"" then
		SELECT venenvio.descripcion,venenvio.pais,     
		venenvio.provincia,venenvio.codpostal,   
		venenvio.localidad,venenvio.domicilio  
		INTO :var_nombre,:var_pais,:var_provincia,:var_codpostal,:var_poblacion,:var_domicilio 
		FROM venenvio  
		WHERE (venenvio.empresa = :codigo_empresa )
		AND (venenvio.cliente = :var_codcli )
		AND (venenvio.codigo  = :venenvio );
	ELSE
		SELECT genter.razon,genter.pais,genter.provincia,genter.cod_postal,   
		genter.domicilio,genter.localidad  
		INTO :var_nombre,:var_pais,:var_provincia,:var_codpostal,   
		:var_domicilio,:var_poblacion  
		FROM genter  
		WHERE (genter.empresa = :codigo_empresa ) AND  
		(genter.tipoter = 'C' ) AND  
		(genter.codigo  = :var_codcli);
	End if

	UPdate  promseries
	Set cliente    = :var_codcli,
	nombre     = :var_nombre,
	domicilio  = :var_domicilio,
	codpostal  = :var_codpostal,
	provincia  = :var_provincia,
	pais       = :var_pais,
	poblacion  = :var_poblacion
	Where  empresa    = :codigo_empresa
	And  codigo     = :nserie;
	
	if sqlca.sqlcode <> 0 then
		messagebox("Error","Al modificar promseries")
		bien = 1
	end if	
End if

if tipoexpo = "2" and repo = "N" then
	if isnull(nserie) or trim(nserie) = "" then
		if not(F_GRABAR_NUEVA_SERIE()) then
			messagebox("Error","Se ha producido un error al grabar la nueva serie")
			bien = 1
		else
			dw_1.accepttext()
		end if
	end if
End if

IF dw_1.GetRow()<>0  Then	
	veces = dw_1.GetItemNumber(dw_1.GetRow(),"veces")
	If IsNull(veces) Then veces = 0
	dw_1.SetItem(dw_1.GetRow(),"veces",veces)
	IF insercion = "S" Then	
		expositor = dw_1.GetItemString(dw_1.GetRow(),"expositor")
		If Trim(expositor) <> "" Then
			f_grabar_paneles()
		END IF			 
	END IF		
	
	anyo      = Dec(em_anyo.text)
	pedido    = Dec(sle_valor.text)
	pais      = dw_1.GetItemString(dw_1.GetRow(),"pais")
	cliente   = dw_1.GetItemString(dw_1.GetRow(),"cliente")
	f_pedido  = dw_1.GetItemDateTime(dw_1.GetRow(),"fpedido")
	f_entrega = dw_1.GetItemDateTime(dw_1.GetRow(),"fentrega")
	agente1   = dw_1.GetItemString(dw_1.GetRow(),"agente1")
	agente2   = dw_1.GetItemString(dw_1.GetRow(),"agente2")
	agente3   = dw_1.GetItemString(dw_1.GetRow(),"agente3")
	tipo_expositor  = dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")
	expositor = dw_1.GetItemString(dw_1.GetRow(),"expositor")
	
	UPDATE promlindetallped  
	SET cliente          = :cliente,   
	pais             = :pais  ,
	f_pedido         = :f_pedido,
	f_entrega        = :f_entrega,
	agente1          = :agente1,
	agente2          = :agente2,						
	agente3          = :agente3,			
	tipo_expositor   = :tipo_expositor,			
	expositor        = :expositor
	WHERE (promlindetallped.empresa = :codigo_empresa )
	AND   (promlindetallped.anyo    = :anyo )
	AND   (promlindetallped.pedido  = :pedido );
	if sqlca.sqlcode <> 0 then
		messagebox("Error","Al modificar promlindetallped")
		bien = 1
	end if
	UPDATE promlinped  
	SET cliente = :cliente,   
	pais    = :pais  ,
	f_pedido      = :f_pedido,
	f_entrega     = :f_entrega,
	agente1       = :agente1,
	agente2       = :agente2,						
	agente3          = :agente3,			
	tipo_expositor   = :tipo_expositor,			
	expositor        = :expositor
	WHERE ( promlinped.empresa  = :codigo_empresa ) AND  
	( promlinped.anyo     = :anyo ) AND  
	( promlinped.pedido   = :pedido )   ;
	if sqlca.sqlcode <> 0 then
		messagebox("Error","Al modificar promlinped")
		bien = 1
	end if
	
END IF

if not(f_calculo_pedido()) then
	bien = 1
end if

dw_1.AcceptText()

if bien = 1 then
	messagebox("Error en proceso","No se actualizan los datos")
	rollback;
else
	call super::ue_actualiza_dw
end if




end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_int_prompedidos
integer x = 5
integer y = 276
integer width = 2866
integer height = 1160
string dataobject = "dw_int_promped5"
boolean livescroll = false
end type

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 f_control_tabulador()	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
AcceptText()
 CHOOSE CASE bus_campo
  CASE "cliente"
     bus_titulo = "VENTANA SELECCION DE CLIENTES"
	  IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
 		bus_datawindow = "dw_ayuda_clientes"
	  Else
		bus_datawindow = "dw_ayuda_vencliproforma"
	  End If
  CASE "envio"
	IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
	END IF
   CASE "correspondencia"
	IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
	END IF
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
  CASE "transportista"
      bus_datawindow = "dw_ayuda_ventransportistas"
     	bus_titulo     = "VENTANA SELECCION DE TANSPORTISTAS"
   CASE "tipo_expositor"
      bus_datawindow = "dw_ayuda_promexpositores"
     	bus_titulo     = "VENTANA SELECCION DE TIPOS DE EXPOSITOR"
	CASE "clase_panel"
      bus_datawindow = "dw_ayuda_promclasepanel"
     	bus_titulo     = "VENTANA SELECCION DE CLASE DE PANELES"		  
   CASE "expositor"
      bus_datawindow = "dw_ayuda_promcabexpositores"
     	bus_titulo     = "VENTANA SELECCION DE EXPOSITORES"
     IF trim(dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")) <> "" Then		  
	      bus_filtro="tipo = '" + dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")+"'"
 	  END IF
   CASE "numserie"
		IF dw_1.GetItemString(1,"reposicion") = "S" Then
     	 	bus_datawindow = "dw_ayuda_promalbseries"
     		bus_titulo     = "VENTANA SELECCION DE SERIES"
      	bus_filtro="cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente")+"'"
		ELSE
			SetNull(bus_campo)
		END IF
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

 CHOOSE CASE bus_campo
     CASE "cliente"
	  dw_1.TriggerEvent("itemchanged")
 END CHOOSE

END IF


end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 AcceptText()
 CHOOSE CASE bus_campo
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMA"
	CASE "cliente"
 	  bus_titulo = "VENTANA SELECCION DE CLIENTES"
	  IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
 		bus_datawindow = "dw_ayuda_clientes"
	  Else
		bus_datawindow = "dw_ayuda_vencliproforma"
	  End If
   CASE "envio"
	IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
	END IF
   CASE "correspondencia"
	IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente") + "'"
	END IF
	CASE "transportista"
	   bus_datawindow = "dw_ayuda_ventransportistas"
     	bus_titulo     = "VENTANA SELECCION DE TANSPORTISTAS"
	CASE "tipo_expositor"
      bus_datawindow = "dw_ayuda_promexpositores"
     	bus_titulo     = "VENTANA SELECCION DE TIPOS DE EXPOSITOR"
  CASE "clase_panel"
      bus_datawindow = "dw_ayuda_promclasepanel"
     	bus_titulo     = "VENTANA SELECCION DE CLASE DE PANELES"	
   CASE "expositor"
      bus_datawindow = "dw_ayuda_promcabexpositores"
     	bus_titulo     = "VENTANA SELECCION DE EXPOSITORES"
      IF trim(dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")) <> "" Then		  
	      bus_filtro="tipo = '" + dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")+"'"
 	   END IF
	 CASE "numserie"
		IF dw_1.GetItemString(1,"reposicion") = "S" Then
     	 	bus_datawindow = "dw_ayuda_promalbseries"
     		bus_titulo     = "VENTANA SELECCION DE SERIES"
      	bus_filtro="cliente = '" + dw_1.GetItemString(dw_1.GetRow(),"cliente")+"'"
		ELSE
			SetNull(bus_campo)
		END IF
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;String nombre

IF consulta ="S" Then Return
f_control_tabulador()
datawindow var_datawindow
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_distribuidores"
AcceptText()
if this.rowcount() > 0 then
	
	nombre = dwo.name
	
	CHOOSE CASE nombre
	
		CASE "pb_cliente"
		  IF f_valor_columna(This,1,"tipo_cliente") = "S" Then
				lstr_param.i_nargumentos    = 2
				lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
				OpenWithParm(wi_mant_clientes2,lstr_param)  
			 ELSE
				lstr_param.i_nargumentos    = 2
				lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
				OpenWithParm(wi_mant_vencliproforma,lstr_param)  
		  END IF
	
		CASE "pb_envio"
			IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
			 lstr_param.i_nargumentos    = 3
			 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
			 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
			 OpenWithParm(wi_mant_venenvio,lstr_param)
			END IF
	
		CASE "pb_correspondencia"
			IF dw_1.GetItemString(GetRow(),"tipo_cliente") = "S" Then
			 lstr_param.i_nargumentos    = 3
			 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
			 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
			 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
			END IF
		 
		 CASE "pb_expositor"
			 lstr_param.i_nargumentos    = 2
			 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"expositor")
			 OpenWithParm(wi_mant_promcabexpositores,lstr_param)
		 
		 CASE "pb_tipo_expositor"
			 lstr_param.i_nargumentos    = 2
			 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_expositor")
			 OpenWithParm(wi_mant_promexpositores,lstr_param)
			 
		 CASE "pb_transpotista"
			 lstr_param.i_nargumentos    = 2
			 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
			 OpenWithParm(wi_mant_ventransportistas,lstr_param)
		 
		 CASE "pb_serie"
			 if len(trim(GetItemString(This.GetRow(),"numserie")))<>0 then 
				  MessageBox("ATENCION!!!!","El expositor ya tiene Nº de Serie",Exclamation!, OK!,1)
				  dw_1.SetColumn("cliente")
				  dw_1.setRow(dw_1.getRow())
				  dw_1.setfocus()
				  Return
			 END IF
		 
			 String tipoexpo,tipoexpositor
			 
			 tipoexpo      = GetItemString(This.GetRow(),"tipo")
			 tipoexpositor = GetItemString(This.GetRow(),"tipo_expositor")
			 
			 if tipoexpo="1" then Return // panel de mano
			 if GetItemString(This.GetRow(),"reposicion")="S" then Return 
			 
			 
			 // Santiago. 18/09/00.Quitamos esta restricción porque no tiene utilidad para nosotros
//			 if tipoexpo="2" and IsNull(tipoexpositor) or len(trim(tipoexpositor))=0 then
//					MessageBox("Campo Obligatorio","Introducir Tipo expositor antes.",Exclamation!, OK!,1)
//					dw_1.SetColumn("tipo_expositor")
//					dw_1.setRow(dw_1.getRow())
//					dw_1.setfocus()
//					REturn
//			 End if
          // Santiago. 18/09/00.Quitamos esta restricción porque no tiene utilidad para nosotros
			
			 lstr_param.i_nargumentos    = 3
			 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
			 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"tipo_expositor")
			 OpenWithParm(wi_mant_promseries,lstr_param)
			 IF len(Message.StringParm)<>0 Then
				string nserie
				nserie = Message.StringParm
				dw_1.setitem(dw_1.getrow(),"numserie",nserie)
			 End if
			 
		CASE "cajas"
			object.juego_de_piezas[1]='N'
		
		CASE "juego_de_piezas"
			object.cajas[1]='N'
	
	END CHOOSE
end if

f_control_tabulador()

call super::clicked
end event

event dw_1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
   f_valores_numericos(dw_1,"cliente")
   f_valores_numericos(dw_1,"agente1")
   f_valores_numericos(dw_1,"agente2")
   f_valores_numericos(dw_1,"agente3")
   f_valores_numericos(dw_1,"envio")
   f_valores_numericos(dw_1,"correspondencia")
   f_valores_numericos(dw_1,"expositor")
   f_valores_numericos(dw_1,"tipo_expositor")
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_1::itemchanged;String codcli
String var_empresa,var_codigo,var_tipoter
str_promped ped

IF dw_1.GetRow() =0 Then Return
codcli  = dw_1.GetItemString(This.GetRow(),"cliente")
if Integer(codcli)=0 then Return
dw_1.AcceptText()
         
if object.tipo[getrow()]='2' then object.juego_de_piezas[getrow()]='N'

			ped.cliente  = dw_1.GetItemString(This.GetRow(),"cliente")
			IF ped.cliente <> antecliente or IsNull(antecliente) Then
				IF dw_1.GetItemString(This.GetRow(),"tipo_cliente") = "S" Then
            SELECT venclientes.zona,venclientes.serie, venclientes.agente1,   
            venclientes.agente2,
            venclientes.transportista,   
            venclientes.forma_envio,
				venclientes.tipo_portes,   
            venclientes.cod_entrega, venclientes.periodo_fac,   
            venclientes.domiciliacion,
            venclientes.envio,           venclientes.correspondencia,   
            venclientes.empresa,         venclientes.codigo  
       INTO :ped.zona, :ped.serie,
		 		:ped.agente1, :ped.agente2,
            :ped.transportista,:ped.forma_envio,   
            :ped.tipo_portes,:ped.cod_entrega,:ped.periodo_fac,
            :ped.domiciliacion,   
            :ped.envio, :ped.correspondencia,:ped.empresa,   
            :ped.cliente 
          FROM venclientes  
          WHERE ( venclientes.empresa = :codigo_empresa ) AND  
                ( venclientes.codigo = :ped.cliente )   
          ORDER BY venclientes.empresa ASC,venclientes.codigo ASC  ;

          Select  genter.empresa,genter.tipoter,genter.codigo,genter.idioma,genter.pais
          Into    :var_empresa,:var_tipoter,:var_codigo,:ped.idioma,:ped.pais
          From genter
          Where   genter.empresa = :codigo_empresa
                  And     genter.tipoter = 'C'
                  And     genter.codigo  = :ped.cliente;
						          dw_1.SetItem(dw_1.GetRow(),"agente1",ped.agente1)
          dw_1.SetItem(dw_1.GetRow(),"pais",ped.pais)
          dw_1.SetItem(dw_1.GetRow(),"agente2",ped.agente2)
          dw_1.SetItem(dw_1.GetRow(),"idioma",ped.idioma)
          dw_1.SetItem(dw_1.GetRow(),"transportista",ped.transportista)
          dw_1.SetItem(dw_1.GetRow(),"serie",ped.serie)
          dw_1.SetItem(dw_1.GetRow(),"zona",ped.zona)
          dw_1.SetItem(dw_1.GetRow(),"envio",ped.envio)
          dw_1.SetItem(dw_1.GetRow(),"correspondencia",ped.correspondencia)
          dw_1.SetItem(dw_1.GetRow(),"domiciliacion",ped.domiciliacion)
          dw_1.SetItem(dw_1.GetRow(),"forma_envio",ped.forma_envio)
          dw_1.SetItem(dw_1.GetRow(),"cod_entrega",ped.cod_entrega)

			ELse
			 Select vencliproforma.pais  Into :ped.pais
			 From vencliproforma
			 Where vencliproforma.empresa  = :codigo_empresa
			 And   vencliproforma.codigo  = :ped.cliente;
          dw_1.SetItem(dw_1.GetRow(),"agente1","")
          dw_1.SetItem(dw_1.GetRow(),"pais",ped.pais)
          dw_1.SetItem(dw_1.GetRow(),"agente2","")
          dw_1.SetItem(dw_1.GetRow(),"idioma","")
          dw_1.SetItem(dw_1.GetRow(),"transportista","")
          dw_1.SetItem(dw_1.GetRow(),"serie","")
          dw_1.SetItem(dw_1.GetRow(),"zona","")
          dw_1.SetItem(dw_1.GetRow(),"envio","")
          dw_1.SetItem(dw_1.GetRow(),"correspondencia","")
          dw_1.SetItem(dw_1.GetRow(),"domiciliacion","")
          dw_1.SetItem(dw_1.GetRow(),"forma_envio","")
          dw_1.SetItem(dw_1.GetRow(),"cod_entrega","")

			END IF

          antecliente = dw_1.GetItemString(dw_1.GetRow(),"cliente")
		END IF
      f_control_tabulador()





end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;f_control_tabulador()
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;f_control_tabulador()
end event

event dw_1::getfocus;call super::getfocus;//if dw_1.RowCount()<>0 then
//	sTring situacion
//	situacion = dw_1.GetItemString(dw_1.GetRow(),"tipo_situacion")
//	IF situacion = "Pedido Servido" then
//		f_mensaje("No se puede modificar","Pedido servido")
//	End if
//End if
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_int_prompedidos
integer x = 0
integer y = 172
integer width = 238
integer height = 68
string text = "Pedido:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_int_prompedidos
integer x = 2075
integer y = 168
integer width = 242
integer height = 72
end type

event cb_insertar::clicked;Integer veces
String   pais,cliente,agente1,agente2,agente3,tipo_expositor,v_expositor
DateTime f_pedido,f_entrega
string repo,tipoexpo,nserie,tipoexpositor,tipocli,var_codcli
String var_pais,var_provincia,var_codpostal,var_poblacion,var_domicilio 
String venenvio,var_nombre

f_control_tabulador()

iF cb_insertar.enabled = TRUE THEN 	
		dw_1.AcceptText()
		var_codcli = dw_1.GetItemString(dw_1.GetRow(),"cliente")
		if dw_1.GetItemString(dw_1.GetRow(),"tipo_cliente")= "S" then
				IF f_activo_genter(codigo_empresa,"C",var_codcli)= "N" Then
					string textoactivo
					textoactivo = f_textoactivo_genter(codigo_empresa,"C",var_codcli)
					MessageBox("Cliente Inactivo",textoactivo+" Para pasar el pedido hay que activarlo.",information!,Ok!) 
					cb_salir.TriggerEvent(clicked!)
					Return
				END IF
		End if
		
		tipoexpo      = dw_1.GetItemString(dw_1.GetRow(),"tipo")
		repo          = dw_1.GetItemString(dw_1.GetRow(),"reposicion")   
		nserie        = dw_1.GetItemString(dw_1.GetRow(),"numserie")
		tipoexpositor = dw_1.GetItemString(dw_1.GetRow(),"tipo_expositor")
		v_expositor     = dw_1.GetItemString(dw_1.GetRow(),"expositor")
		
		//Santiago.18/09/00.Quitamos esta restricción porque de momento no la necesitamos
//		if tipoexpo= "2" and (IsNull(tipoexpositor) or len(trim(tipoexpositor))=0)  then
//			MessageBox("Campo Obligatorio","Introducir Tipo expositor",Exclamation!, OK!,1)
//			dw_1.SetColumn("tipo_expositor")
//			dw_1.setRow(dw_1.getRow())
//			dw_1.setfocus()
//			REturn
//		End if
		//Santiago.18/09/00.Quitamos esta restricción porque de momento no la necesitamos
		if tipoexpo= "2" and (IsNull(v_expositor) or len(trim(v_expositor))=0)  then
			MessageBox("Campo Obligatorio","Introducir expositor",Exclamation!, OK!,1)
			dw_1.SetColumn("expositor")
			dw_1.setRow(dw_1.getRow())
			dw_1.setfocus()
			REturn
		End if
End if


call super::clicked



end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_int_prompedidos
integer x = 2322
integer y = 168
integer width = 251
integer height = 72
end type

event cb_borrar::clicked;commit;
Integer registros
Dec{0} var_anyo,var_pedido
var_anyo   = Dec(em_anyo.text)
var_pedido = Dec(sle_valor.text)

 // control de borrar
 
 if f_pedido_impreso_promo(codigo_empresa,var_anyo,var_pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para borrarlo.")
			 f_activar_campo(sle_valor)
			 Return
	End if
 End if

String borrado
borrado ="S"

  Select count(*) Into :registros From promlinped
  Where  empresa = :codigo_empresa
  And    anyo    = :var_anyo
  And    pedido  = :var_pedido
  And    situacion = "P";
  IF ISNull(registros)  Then registros = 0
  IF registros <> 0 then
    f_mensaje("El pedido no se puede borrar"," Existen lineas preparadas")
	 borrado = "N"
  END IF
  IF borrado="S" Then
   Select count(*) Into :registros From promlinped
   Where  empresa    = :codigo_empresa
   And    anyo       = :var_anyo
   And    pedido     = :var_pedido
   And    situacion  = "S";
   IF ISNull(registros)  Then registros = 0
	IF registros <> 0 then
    f_mensaje("El pedido no puede ser borrado"," Existen lines servidas")
	 borrado = "N"
  END IF
  END IF
  
 IF borrado = "S" Then
 IF f_control_borrado() THEN 
  CALL Super::Clicked
 END IF
END IF

 f_activar_campo(em_anyo)

end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_int_prompedidos
integer y = 164
integer width = 242
integer height = 80
integer taborder = 40
maskdatatype maskdatatype = numericmask!
string mask = "######"
end type

event sle_valor::getfocus;call super::getfocus;dw_1.SetTabOrder("cliente",10)
if Trim(em_anyo.text)="" or  IsNull(em_anyo.text)   then
        f_activar_campo(em_anyo)	
        RETURN
end iF

pb_calculadora.visible=TRUE

ant_cliente   = ""
ue_titulo     = ""
ue_datawindow = ""
ue_filtro     = ""
isle_campo    = this
IF istr_parametros.i_nargumentos>1 THEN
	  em_anyo.text=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
 	  istr_parametros.i_nargumentos=0
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
		   Parent.TriggerEvent("ue_recuperar")
   		cb_pallets.enabled = FALSE
			return
	  END IF     
END IF

dw_1.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(sle_valor.text))
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_int_prompedidos
integer x = 2574
integer y = 168
integer width = 256
integer height = 72
string text = "&Salir "
end type

event cb_salir::clicked;iF cb_insertar.enabled =TRUE THEN 
	IF insercion = "S" then 
		string nserie
		nserie = dw_1.GetItemString(dw_1.GetRow(),"numserie")
		if len(trim(nserie))<>0 then
				Delete from promseries
				Where  promseries.empresa  = :codigo_empresa
				And    promseries.codigo   = :nserie;
		End if
   END IF 
 Else
	IF control_lineas = "S" Then
		f_mensaje("No se puede cerrar el pedido","Las lineas estan abiertas")
		Return
	END IF
End if

call super::clicked


end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_int_prompedidos
integer taborder = 50
end type

event control_tabulador::getfocus;IF consulta = "S" Then 
	f_activar_campo(uo_cliente.em_campo)
Else
	CALL Super::getfocus
END IF
end event

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_int_prompedidos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_int_prompedidos
integer x = 64
integer y = 16
integer width = 2578
end type

type pb_calculadora from u_calculadora within w_int_prompedidos
integer x = 745
integer y = 156
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
IF Trim(em_anyo.text)=""  THEN Return

dec{0} n_pedido,var_pedido
Dec{0} registros,numero,anyo
String  var_empresa

em_anyo.text = String(Year(Today()))
anyo = Integer(em_anyo.text)
registros = 0
  SELECT promcontador.empresa,promcontador.pedidos  
    INTO :var_empresa,:registros  
    FROM promcontador  
   WHERE promcontador.empresa = :codigo_empresa  
   And   promcontador.anyo    = :anyo ;
   If Sqlca.Sqlcode=100 Then
		IF IsNull(registros) Then registros = 0
       INSERT INTO promcontador (empresa,anyo,pedidos)  
       VALUES (:codigo_empresa,:anyo,:registros );
       COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_pedido= registros

   Select count(*) Into :numero From promped
   Where   promped.empresa  = :codigo_empresa
   And     promped.anyo     = :anyo
   And     promped.pedido   = :n_pedido;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((promped.pedido)+1)
       Into   :var_pedido
       From   promped
       Where  promped.empresa = :codigo_empresa
       And    promped.anyo    = :anyo;
		 sle_valor.text = String(var_pedido)
       registros= var_pedido
   End If
   UPDATE promcontador  
   SET    pedidos = :registros  
   WHERE  promcontador.empresa = :codigo_empresa
   And    promcontador.anyo    = :anyo;
   COMMIT;

   sle_valor.text=String(registros)
   dw_1.TriggerEvent("Clicked")
end event

type pb_salir from upb_salir within w_int_prompedidos
integer x = 2720
integer y = 12
integer width = 119
integer height = 108
integer taborder = 0
end type

event clicked;IF consulta ="S" THEN
	gb_1.visible            = TRUE
	cb_salir.visible        = TRUE
	cb_insertar.visible     = TRUE
	cb_pallets.visible      = TRUE
   cb_borrar.enabled       = TRUE
	cb_borrar.visible       = TRUE
	cb_imprimir.visible     = TRUE
	cb_consulta.enabled     = TRUE
	cb_consulta.visible     = TRUE
	dw_1.enabled            = TRUE
	dw_1.visible            = TRUE
	sle_valor.enabled       = TRUE
	sle_valor.visible       = TRUE
	pb_calculadora.enabled  = TRUE
	pb_calculadora.visible  = TRUE
	em_anyo.enabled         = TRUE
	em_anyo.visible         = TRUE
	cb_lineas.enabled       = TRUE
	cb_lineas.visible       = TRUE
	st_1.visible            = TRUE
		
	ddlb_1.visible        = FALSE
	uo_cliente.enabled    = FALSE
	uo_cliente.visible    = FALSE
	st_cliente.visible    = FALSE
	dw_lineas.enabled     = FALSE
	dw_lineas.visible     = FALSE
	uo_manejo.visible     = FALSE
   
	consulta="N"
   IF trim(em_anyo.text) = "" Then
        f_activar_campo(em_anyo)
     ELSE
        f_activar_campo(sle_valor)
   END IF
   Return

ELSE
	
	IF control_lineas = "S" Then
		f_mensaje("No se puede cerrar el pedido","Las lineas estan abiertas")
		Return
	END IF
   CALL Super::clicked

END IF
end event

type dw_report from datawindow within w_int_prompedidos
boolean visible = false
integer width = 622
integer height = 96
boolean bringtotop = true
string dataobject = "report_list_prompedidos"
boolean livescroll = true
end type

type st_cliente from statictext within w_int_prompedidos
boolean visible = false
integer y = 172
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_lineas from datawindow within w_int_prompedidos
boolean visible = false
integer x = 18
integer y = 268
integer width = 2862
integer height = 1156
string dataobject = "dw_int_promped2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;If consulta ="N" THEN Return
IF Row =0 Then
 f_activar_campo(uo_cliente.em_campo)
 Return
END IF

em_anyo.text    = String(This.GetItemNumber(Row,"anyo"))
sle_valor.text  = String(This.GetItemNumber(Row,"pedido"))


pb_salir.TriggerEvent(clicked!)
end event

type dw_proceso from datawindow within w_int_prompedidos
boolean visible = false
integer x = 640
integer width = 274
integer height = 84
boolean bringtotop = true
string dataobject = "dw_proceso_prompanexpositores"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_imprimir from u_boton within w_int_prompedidos
integer x = 1490
integer y = 168
integer width = 297
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F6 Imprime"
end type

event clicked;
IF Trim(sle_valor.text) = "" THEN Return

str_parametros pa
Dec{0} anyo,pedido
anyo   = Dec(em_anyo.text)
pedido = Dec(sle_valor.text)

// control de Imprimir
 
if f_pedido_impreso_promo(codigo_empresa,anyo,pedido) then
	if acceso<>"1" then
			 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para volver a imprimir.")
			 f_activar_campo(sle_valor)
			 Return
	End if
End if

if trim(dw_1.object.expositor[dw_1.getrow()]) <> "" and not(isnull(dw_1.object.expositor[dw_1.getrow()])) then
	if f_paneles_expositor(codigo_empresa,dw_1.object.expositor[dw_1.getrow()]) then
 		dw_report.DataObject = 'report_list_prompedidos'
	else
		dw_report.DataObject = 'report_list_prompedidos_sin_paneles'
	end if
else
	dw_report.DataObject = 'report_list_prompedidos'
end if
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(codigo_empresa,anyo,pedido)
pa.s_listado = dw_report.DataObject
f_activar_campo(sle_valor)

String impresora,cadena,impre
/*impre = dw_report.Describe("Datawindow.Printer")
SELECT ven_usuimpre.impresora_preparacion
INTO :impresora  
FROM ven_usuimpre
Where empresa = :codigo_empresa
And   usuario = :nombre_usuario;
IF impre <> impresora Then
  MessageBox("Selecciona la impresora predeterminada","La impresora debe de ser" + impresora,Exclamation!,OK!,1)
  printSetup()
 ELse
  //dw_REPORT.Modify(" datawindow.print.copies = 2")
  //dw_report.print() */
  f_imprimir_datawindow(dw_report)
  f_grabar_flistado_promped(codigo_empresa,anyo,pedido)
//END IF

dw_1.Retrieve(codigo_empresa,Integer(em_anyo.text),Dec(sle_valor.text))
f_activar_campo(sle_valor)










end event

type cb_lineas from u_boton within w_int_prompedidos
integer x = 1207
integer y = 168
integer width = 283
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F5 Lineas"
end type

event clicked;
Integer anyo
Dec pedido
String reposicion

anyo    = Integer(em_anyo.text)
pedido  = Dec(sle_valor.text)

Select promped.pedido,promped.reposicion	 
Into :pedido,:reposicion
from promped
where  promped.empresa = :codigo_empresa
and    promped.anyo    = :anyo
and    promped.pedido  = :pedido;
IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo del pedido no existe","Introduzca el pedido",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF



titulo = Parent.title

// Valores Para Funcion de bloqueo
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]+criterio[3]
 tabla        = "promped"
IF NOT f_bloquear(tabla,seleccion,titulo) THEN
 COMMIT;
 str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 lstr_param.s_argumentos[4]=dw_1.GetItemString(dw_1.GetRow(),"reposicion")
 f_activar_campo(sle_valor)
 control_lineas= "S"

if trim(dw_1.object.expositor[dw_1.getrow()]) <> "" and not(isnull(dw_1.object.expositor[dw_1.getrow()])) then
	//this.getparent().hide()
	if f_paneles_expositor(codigo_empresa,dw_1.object.expositor[dw_1.getrow()]) then
 		OpenWithParm(w_int_promliped,lstr_param)
	else
		OpenWithParm(w_int_promliped_exp_sin_paneles,lstr_param)
	end if
else
	//this.parent.hide()
	OpenWithParm(w_int_promliped,lstr_param)
end if
END IF
end event

type cb_consulta from u_boton within w_int_prompedidos
integer x = 882
integer y = 168
integer width = 325
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F4 Consulta"
end type

event clicked;call super::clicked;cb_consulta.enabled     = FALSE
cb_consulta.visible     = FALSE
cb_lineas.enabled       = FALSE
cb_lineas.visible       = FALSE
cb_salir.visible        = FALSE
cb_imprimir.visible     = FALSE
cb_insertar.visible     = FALSE
cb_borrar.visible       = FALSE
cb_pallets.visible      = FALSE
gb_1.visible            = FALSE

dw_1.enabled            = FALSE
dw_1.visible            = FALSE
sle_valor.enabled       = FALSE
sle_valor.visible       = FALSE
em_anyo.enabled         = FALSE
em_anyo.visible         = FALSE
pb_calculadora.enabled  = FALSE
pb_calculadora.visible  = FALSE

st_1.visible            = FALSE


ddlb_1.visible        = true
uo_cliente.visible    = TRUE
uo_cliente.enabled    = TRUE
st_cliente.visible    = TRUE
dw_lineas.visible     = TRUE
dw_lineas.enabled     = TRUE
uo_manejo.visible     = TRUE


consulta="S"
f_activar_campo(uo_cliente.em_campo)
end event

type cb_pallets from u_boton within w_int_prompedidos
event clicked pbm_bnclicked
integer x = 1787
integer y = 168
integer width = 279
integer height = 72
integer taborder = 0
boolean bringtotop = true
string text = "F7 Pallets"
end type

event clicked;call super::clicked;Integer anyo
Dec pedido
pb_salir.enabled = FALSE
anyo    = Integer(em_anyo.text)
pedido  = Dec(sle_valor.text)

Select promped.pedido Into :pedido from promped
where  promped.empresa = :codigo_empresa
and    promped.anyo    = :anyo
and    promped.pedido  = :pedido;
IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo del pedido no existe","Introduzca el pedido",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF

f_detalle()


end event

type dw_detalle from u_datawindow within w_int_prompedidos
boolean visible = false
integer y = 288
integer width = 2862
integer height = 752
integer taborder = 0
boolean titlebar = true
string title = "DETALLE PALLETS PEDIDO PROMOCION"
string dataobject = "dw_int_promped3"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;IF f_objeto_datawindow(This) = "grabar" Then  f_insertar_linea()
IF f_objeto_datawindow(This) = "borrar" Then  f_borrar_linea()
IF f_objeto_datawindow(This) = "salir"  Then  f_salir_detalle()

end event

event key;
IF KeyDown(KeyF2!) Then  f_insertar_linea()
IF KeyDown(KeyF3!) Then  f_borrar_linea()
IF KeyDown(KeyEscape!) Then  f_salir_detalle()




 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  CASE "tipo_pallets"
 		bus_datawindow = "dw_ayuda_pallets"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLETS"
  CASE "zona"
 		bus_datawindow = "dw_ayuda_almubizonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
      bus_filtro = "almacen = '" + dw_detalle.getItemString(dw_detalle.GetRow(),"almacen")+ "'"

  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

end event

event rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 
 CHOOSE CASE bus_campo

  CASE "tipo_pallets"
 		bus_datawindow = "dw_ayuda_pallets"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLETS"
  CASE "zona"
 		bus_datawindow = "dw_ayuda_almubizonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
      bus_filtro = "almacen = '" + dw_detalle.getItemString(dw_detalle.GetRow(),"almacen")+ "'"

  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 
 CALL Super::rbuttondown
end event

event rowfocuschanged;call super::rowfocuschanged;If dw_detalle.GetRow() = 0 Then Return
IF dw_detalle.GetItemString(dw_detalle.GetRow(),"situacion") = "S" Then
	dw_detalle.SETTabOrder("fila",0)
	dw_detalle.SETTabOrder("altura",0)
	dw_detalle.SETTabOrder("pallets",0)
		dw_detalle.SETTabOrder("tipo_pallets",0)
	dw_detalle.SETTabOrder("observaciones",0)
Else
	dw_detalle.SETTabOrder("fila",1)
	dw_detalle.SETTabOrder("altura",2)
	dw_detalle.SETTabOrder("pallets",3)
		dw_detalle.SETTabOrder("tipo_pallets",4)
	dw_detalle.SETTabOrder("observaciones",5)

 END IF
end event

event getfocus;call super::getfocus;If dw_detalle.GetRow() = 0 Then Return
IF dw_detalle.GetItemString(dw_detalle.GetRow(),"situacion") = "S" Then
	dw_detalle.SETTabOrder("fila",0)
	dw_detalle.SETTabOrder("altura",0)
	dw_detalle.SETTabOrder("pallets",0)
		dw_detalle.SETTabOrder("tipo_pallets",0)
	dw_detalle.SETTabOrder("observaciones",0)
Else
	dw_detalle.SETTabOrder("fila",1)
	dw_detalle.SETTabOrder("altura",2)
	dw_detalle.SETTabOrder("pallets",3)
		dw_detalle.SETTabOrder("tipo_pallets",4)
	dw_detalle.SETTabOrder("observaciones",5)

 END IF
end event

type uo_cliente from u_em_campo_2 within w_int_prompedidos
event destroy ( )
boolean visible = false
integer x = 512
integer y = 164
integer width = 1111
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
Else
   uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)	
End if

IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
 Return
END IF

string tipo_cli
tipo_cli ="N"
if ddlb_1.text = "Si" then tipo_cli = "S"

dw_lineas.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo_cli)
end event

event getfocus;call super::getfocus;if ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
   ue_datawindow ="dw_ayuda_clientes"
   ue_filtro = ""
Else
	ue_titulo = "Selección de no clientes"
   ue_datawindow ="dw_ayuda_vencliproforma"
   ue_filtro = ""
End if

end event

type em_anyo from u_em_campo within w_int_prompedidos
integer x = 247
integer y = 164
integer width = 238
integer height = 80
integer taborder = 10
string facename = "Courier"
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE
dw_1.reset()

ue_titulo     = ""
ue_datawindow = ""
ue_filtro     = ""		
isle_campo    = this




end event

type ddlb_1 from dropdownlistbox within w_int_prompedidos
integer x = 247
integer y = 164
integer width = 238
integer height = 228
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Si","No"}
end type

type dw_proceso2 from datawindow within w_int_prompedidos
boolean visible = false
integer x = 928
integer width = 274
integer height = 80
boolean bringtotop = true
string dataobject = "dw_proceso_prommapapaneles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_int_prompedidos
integer x = 864
integer y = 132
integer width = 1984
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_manejo from u_manejo_datawindow within w_int_prompedidos
boolean visible = false
integer x = 2254
integer y = 116
integer width = 613
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_lineas
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

