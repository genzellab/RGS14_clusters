#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 22 21:11:14 2024

@author: adrian
"""
import plotly.tools as tls
import plotly.io as pio

plotly_fig=tls.mpl_to_plotly(fig)
pio.write_html(plotly_fig, file='3d_plot.html', auto_open=True)

#%%

from mpl_toolkits.mplot3d import Axes3D
import mpld3

mpld3.save_html(fig, '3d_plot.html')
#%%

fig = plt.figure(figsize=(15, 15))
# Create 4 subplots: 2x2 grid
ax_3d_1 = fig.add_subplot(221, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(222, projection='3d')  # Second subplot (3D)

ax_2d_1 = fig.add_subplot(223)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(224)  # Second subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno'] 

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    return contour

# Plot 3D clusters
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1) 
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_1)
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_1)

# Plot 2D contour for each cluster
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[0], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)

# Customize 3D plot
ax_3d_1.set_title('VEH (Clusters) 3D')
ax_3d_1.set_xlabel('PCA1')
ax_3d_1.set_ylabel('PCA2')
ax_3d_1.set_zlabel('PCA3')

# Customize 2D plot
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')

# Colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)

plt.tight_layout()
plt.show()

#%%
fig = plt.figure(figsize=(15, 15))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax, xlim=None, ylim=None):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set axis limits if provided
    if xlim:
        ax.set_xlim(xlim)
    if ylim:
        ax.set_ylim(ylim)
    
    return contour

# Find global xlim and ylim for the 2D plots
xlim = [min(x_axis1.min(), x_axis2.min(), x_axis3.min()), max(x_axis1.max(), x_axis2.max(), x_axis3.max())]
ylim = [min(y_axis1.min(), y_axis2.min(), y_axis3.min()), max(y_axis1.max(), y_axis2.max(), y_axis3.max())]

# Plot 3D clusters
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[0], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[2], ax_3d_3)  # Cluster 3

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[0], ax_2d_1, xlim=xlim, ylim=ylim)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2, xlim=xlim, ylim=ylim)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[2], ax_2d_3, xlim=xlim, ylim=ylim)

# Customize 3D plots
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plots
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)
fig.colorbar(contour3, ax=ax_2d_3)

plt.tight_layout()
plt.show()
#%%
fig = plt.figure(figsize=(15, 15))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax, xlim=None, ylim=None):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set axis limits if provided
    if xlim:
        ax.set_xlim(xlim)
    if ylim:
        ax.set_ylim(ylim)
    
    return contour

# Find global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [min(x_axis1.min(), x_axis2.min(), x_axis3.min()), max(x_axis1.max(), x_axis2.max(), x_axis3.max())]
ylim = [min(y_axis1.min(), y_axis2.min(), y_axis3.min()), max(y_axis1.max(), y_axis2.max(), y_axis3.max())]
zlim = [min(z_axis1.min(), z_axis2.min(), z_axis3.min()), max(z_axis1.max(), z_axis2.max(), z_axis3.max())]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[0], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[2], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[0], ax_2d_1, xlim=xlim, ylim=ylim)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2, xlim=xlim, ylim=ylim)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[2], ax_2d_3, xlim=xlim, ylim=ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Add colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)
fig.colorbar(contour3, ax=ax_2d_3)

plt.tight_layout()
plt.show()

#%%
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import numpy as np

fig = plt.figure(figsize=(18, 10))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set labels for 2D plots
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    
    return contour

# # Find global xlim, ylim for 2D plots and zlim for 3D plots
# xlim = [min(x_axis1.min(), x_axis2.min(), x_axis3.min()), max(x_axis1.max(), x_axis2.max(), x_axis3.max())]
# ylim = [min(y_axis1.min(), y_axis2.min(), y_axis3.min()), max(y_axis1.max(), y_axis2.max(), y_axis3.max())]
# zlim = [min(z_axis1.min(), z_axis2.min(), z_axis3.min()), max(z_axis1.max(), z_axis2.max(), z_axis3.max())]

xlim=[-3.82235,7.2036568]
ylim=[-5.176079, 6.549440947]
zlim=[-4.36141484439, 5.047662087]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[2], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[0], ax_2d_3)

# Ensure the same axis limits for all 2D plots
for ax in [ax_2d_1, ax_2d_2, ax_2d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Add colorbars for 2D plots
col1=fig.colorbar(contour1, ax=ax_2d_1)
col2=fig.colorbar(contour2, ax=ax_2d_2)
col3=fig.colorbar(contour3, ax=ax_2d_3)

# Add some spacing to avoid label overlap
plt.tight_layout(pad=3.0)  # Adjust padding to avoid overlap
plt.show()

# Get the color limits of each contour
vmin1, vmax1rgs = contour1.get_clim()
vmin2, vmax2rgs = contour2.get_clim()
vmin3, vmax3rgs = contour3.get_clim()
# # Get the color limits of each contour
# vmin1, vmax1 = contour1.get_clim()
# vmin2, vmax2 = contour2.get_clim()
# vmin3, vmax3 = contour3.get_clim()
Vmax1=0.3
Vmax2=0.315
Vmax3=0.108
contour1.set_clim(vmin=0, vmax=Vmax1)
contour2.set_clim(vmin=0, vmax=Vmax2)
contour3.set_clim(vmin=0, vmax=Vmax3)
col1.vmax=Vmax1
col2.vmax=Vmax2
col3.vmax=Vmax3

#%%

import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import numpy as np

fig = plt.figure(figsize=(18, 10))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set labels for 2D plots
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    
    return contour

# Global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [-3.82235, 7.2036568]
ylim = [-5.176079, 6.549440947]
zlim = [-4.36141484439, 5.047662087]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[2], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[0], ax_2d_3)

# Ensure the same axis limits for all 2D plots
for ax in [ax_2d_1, ax_2d_2, ax_2d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Set clim values for the contours
Vmax1 = 0.3
Vmax2 = 0.315
Vmax3 = 0.108

contour1.set_clim(vmin=0, vmax=Vmax1)
contour2.set_clim(vmin=0, vmax=Vmax2)
contour3.set_clim(vmin=0, vmax=Vmax3)

# Recreate the colorbars to reflect the updated limits
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)
fig.colorbar(contour3, ax=ax_2d_3)

# Add some spacing to avoid label overlap
plt.tight_layout(pad=3.0)
plt.show()

# Print the color limits for verification
print("Contour 1 clim:", contour1.get_clim())
print("Contour 2 clim:", contour2.get_clim())
print("Contour 3 clim:", contour3.get_clim())



#%%
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import numpy as np

fig = plt.figure(figsize=(18, 10))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set labels for 2D plots
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    
    return contour

# Global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [-3.82235, 7.2036568]
ylim = [-5.176079, 6.549440947]
zlim = [-4.36141484439, 5.047662087]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[2], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[0], ax_2d_3)

# Ensure the same axis limits for all 2D plots
for ax in [ax_2d_1, ax_2d_2, ax_2d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Set clim values for the contours
Vmax1 = 0.3
Vmax2 = 0.315
Vmax3 = 0.108

# Set color limits for the contours, even if they don't reach these values
contour1.set_clim(vmin=0, vmax=Vmax1)
contour2.set_clim(vmin=0, vmax=Vmax2)
contour3.set_clim(vmin=0, vmax=Vmax3)

# Recreate the colorbars to reflect the updated limits
cbar1 = fig.colorbar(contour1, ax=ax_2d_1)
cbar2 = fig.colorbar(contour2, ax=ax_2d_2)
cbar3 = fig.colorbar(contour3, ax=ax_2d_3)

# Manually set the ticks and limits of the colorbars to match the desired range
cbar1.set_ticks(np.linspace(0, Vmax1, num=5))
cbar2.set_ticks(np.linspace(0, Vmax2, num=5))
cbar3.set_ticks(np.linspace(0, Vmax3, num=5))

# Add some spacing to avoid label overlap
plt.tight_layout(pad=3.0)
plt.show()

# Print the color limits for verification
print("Contour 1 clim:", contour1.get_clim())
print("Contour 2 clim:", contour2.get_clim())
print("Contour 3 clim:", contour3.get_clim())
#%%

import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import numpy as np

fig = plt.figure(figsize=(18, 10))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set labels for 2D plots
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    
    return contour

# Global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [-3.82235, 7.2036568]
ylim = [-5.176079, 6.549440947]
zlim = [-4.36141484439, 5.047662087]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[2], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[0], ax_2d_3)

# Ensure the same axis limits for all 2D plots
for ax in [ax_2d_1, ax_2d_2, ax_2d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Set clim values for the contours
Vmax1 = 0.3
Vmax2 = 0.315
Vmax3 = 0.108

# Set color limits for the contours, even if they don't reach these values
contour1.set_clim(vmin=0, vmax=Vmax1)
contour2.set_clim(vmin=0, vmax=Vmax2)
contour3.set_clim(vmin=0, vmax=Vmax3)

# Recreate the colorbars to reflect the updated limits
cbar1 = fig.colorbar(contour1, ax=ax_2d_1)
cbar2 = fig.colorbar(contour2, ax=ax_2d_2)
cbar3 = fig.colorbar(contour3, ax=ax_2d_3)

# Set the ticks of the colorbar to only show the vmax (highest value)
cbar1.set_ticks([Vmax1])
cbar2.set_ticks([Vmax2])
cbar3.set_ticks([Vmax3])

# Add some spacing to avoid label overlap
plt.tight_layout(pad=3.0)
plt.show()

# Print the color limits for verification
print("Contour 1 clim:", contour1.get_clim())
print("Contour 2 clim:", contour2.get_clim())
print("Contour 3 clim:", contour3.get_clim())
#%%
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import numpy as np

fig = plt.figure(figsize=(18, 10))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set labels for 2D plots
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    
    return contour

# Global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [-3.82235, 7.2036568]
ylim = [-5.176079, 6.549440947]
zlim = [-4.36141484439, 5.047662087]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[2], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[0], ax_2d_3)

# Ensure the same axis limits for all 2D plots
for ax in [ax_2d_1, ax_2d_2, ax_2d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Set clim values for the contours
Vmax1 = 0.3
Vmax2 = 0.315
Vmax3 = 0.108

# Set color limits for the contours, even if they don't reach these values
contour1.set_clim(vmin=0, vmax=Vmax1)
contour2.set_clim(vmin=0, vmax=Vmax2)
contour3.set_clim(vmin=0, vmax=Vmax3)

# Recreate the colorbars to reflect the updated limits
cbar1 = fig.colorbar(contour1, ax=ax_2d_1)
cbar2 = fig.colorbar(contour2, ax=ax_2d_2)
cbar3 = fig.colorbar(contour3, ax=ax_2d_3)

# Manually set the colorbar ticks to include the vmax
cbar1.set_ticks([0, Vmax1])
cbar2.set_ticks([0, Vmax2])
cbar3.set_ticks([0, Vmax3])

# Add some spacing to avoid label overlap
plt.tight_layout(pad=3.0)
plt.show()

# Print the color limits for verification
print("Contour 1 clim:", contour1.get_clim())
print("Contour 2 clim:", contour2.get_clim())
print("Contour 3 clim:", contour3.get_clim())

#%%
Elev=30
# Generate and save frames
for angle in range(0,360, 5):  # Rotate every 2 degrees
    ax_3d_1.view_init(azim=angle,elev=Elev)
    ax_3d_2.view_init(azim=angle,elev=Elev)
    #ax_3d_3.view_init(azim=angle,elev=Elev)    
    plt.savefig(f"frame_{angle}.png", dpi=300)  # Save each frame
#%%
from moviepy.editor import ImageSequenceClip

# List of all the frame files
frames = [f"frame_{angle}.png" for angle in range(0, 360, 5)]

# Create a video clip
clip = ImageSequenceClip(frames, fps=2)

# Save the video
clip.write_videofile("rotating_3D_plot_v14.mp4", codec="mpeg4")

#%%
fig = plt.figure(figsize=(15, 15))
# Create 4 subplots: 2x2 grid
ax_3d_1 = fig.add_subplot(221, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(222, projection='3d')  # Second subplot (3D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno'] 

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Plot 3D clusters
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1) 
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_1)
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_1)


# Customize 3D plot
ax_3d_1.set_title('VEH (Clusters) 3D')
ax_3d_1.set_xlabel('PCA1')
ax_3d_1.set_ylabel('PCA2')
ax_3d_1.set_zlabel('PCA3')


cbar1=fig.colorbar(sc1, ax=ax_3d_1)
ticks = cbar1.get_ticks()
cbar1.set_ticks([ticks[-1]])
cbar1.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
cbar1.set_ticks(ticks)
cbar1.set_ticks([ticks[-1]])


cbar2=fig.colorbar(sc2, ax=ax_3d_1)
ticks = cbar2.get_ticks()
cbar2.set_ticks([ticks[-1]])
cbar2.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
cbar2.set_ticks(ticks)
cbar2.set_ticks([ticks[-1]])

cbar3=fig.colorbar(sc3, ax=ax_3d_1)
ticks = cbar3.get_ticks()
cbar3.set_ticks([ticks[-1]])
cbar3.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
cbar3.set_ticks(ticks)
cbar3.set_ticks([ticks[-1]])

# Combine clusters 1,2 and 3. Amount of ripples per cluster is similar.
x = np.concatenate((x_axis1, x_axis3,x_axis2), axis=0)
y = np.concatenate((y_axis1, y_axis3,y_axis2), axis=0)
z = np.concatenate((z_axis1, z_axis3,z_axis2), axis=0)

cmaps = ['inferno'] #, 'plasma', 'inferno',plasma cividis

# Plot clusters on the third subplot (ax3)
sc9 = plot_cluster_3d(x, y, z, cmaps[0], ax_3d_2)  # Cluster 3
ax_3d_2.set_title('VEH (All ripples) 3D')
ax_3d_2.set_xlabel('PCA1')
ax_3d_2.set_ylabel('PCA2')
ax_3d_2.set_zlabel('PCA3')

cbar4=fig.colorbar(sc9, ax=ax_3d_2)

ticks = cbar4.get_ticks()
cbar4.set_ticks([ticks[-1]])
cbar4.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
cbar4.set_ticks(ticks)
cbar4.set_ticks([ticks[-1]])

plt.tight_layout()
plt.show()
#%%
import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import gaussian_kde

# Create figure
fig = plt.figure(figsize=(15, 15))

# Create 2 subplots for 3D scatter plots (2x1 grid)
ax_3d_1 = fig.add_subplot(221, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(222, projection='3d')  # Second subplot (3D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno'] 

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Plot 3D clusters on the first subplot
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1) 
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_1)
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_1)

# Customize the first 3D plot
ax_3d_1.set_title('VEH (Clusters) 3D')
ax_3d_1.set_xlabel('PCA1')
ax_3d_1.set_ylabel('PCA2')
ax_3d_1.set_zlabel('PCA3')

# Combine clusters 1, 2, and 3 for the second 3D plot
x_combined = np.concatenate((x_axis1, x_axis3, x_axis2), axis=0)
y_combined = np.concatenate((y_axis1, y_axis3, y_axis2), axis=0)
z_combined = np.concatenate((z_axis1, z_axis3, z_axis2), axis=0)

# Plot combined clusters on the second 3D subplot
sc_combined = plot_cluster_3d(x_combined, y_combined, z_combined, cmaps[0], ax_3d_2)
ax_3d_2.set_title('VEH (All ripples) 3D')
ax_3d_2.set_xlabel('PCA1')
ax_3d_2.set_ylabel('PCA2')
ax_3d_2.set_zlabel('PCA3')

# Adjust colorbars to avoid shrinking the scatter plots
# Get the positions of the first and second 3D plots
pos1 = ax_3d_1.get_position()  # Position of ax_3d_1
pos2 = ax_3d_2.get_position()  # Position of ax_3d_2

sc1.set_clim(new_lower_limit_1_5, 0.3)
sc2.set_clim(new_lower_limit_2_6, 0.4)
sc3.set_clim(new_lower_limit_3_7, 0.12)

sc_combined.set_clim(new_lower_limit_9_11,0.14)

# Define new positions for the colorbars
cbar1 = fig.add_axes([pos1.x1 + 0.01, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Colorbar for ax_3d_1
colorbar1 = fig.colorbar(sc1, cax=cbar1, label='KDE Cluster 1')
ticks = colorbar1.get_ticks()
colorbar1.set_ticks([ticks[-1]])
colorbar1.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
colorbar1.set_ticks(ticks)
colorbar1.set_ticks([ticks[-1]])

cbar2 = fig.add_axes([pos1.x1 + 0.05, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Colorbar for ax_3d_2
colorbar2 = fig.colorbar(sc2, cax=cbar2, label='KDE Cluster 2')
#ticks = colorbar2.get_ticks()
ticks=[0.4]
colorbar2.set_ticks([ticks[-1]])
colorbar2.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
colorbar2.set_ticks(ticks)
colorbar2.set_ticks([ticks[-1]])

cbar3 = fig.add_axes([pos1.x1 + 0.09, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Colorbar for ax_3d_1
colorbar3 = fig.colorbar(sc3, cax=cbar3, label='KDE Cluster 3')
ticks = colorbar3.get_ticks()
colorbar3.set_ticks([ticks[-1]])
colorbar3.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
colorbar3.set_ticks(ticks)
colorbar3.set_ticks([ticks[-1]])

colorbar1.set_label('KDE Cluster 1', labelpad=-18)
colorbar2.set_label('KDE Cluster 2', labelpad=-18)
colorbar3.set_label('KDE Cluster 3', labelpad=-18)

# sc1.set_clim(new_lower_limit_1_5, 0.3)
# sc2.set_clim(new_lower_limit_2_6, 0.4)
# sc3.set_clim(new_lower_limit_3_7, 0.12)
# Repeat for the second scatter plot
cbar_combined = fig.add_axes([pos2.x1 + 0.04, pos2.y0+0.05, 0.01, pos2.height-0.1])
colorbar_combined = fig.colorbar(sc_combined, cax=cbar_combined, label='KDE Combined')
ticks = colorbar_combined.get_ticks()
colorbar_combined.set_ticks([ticks[-1]])
colorbar_combined.ax.set_yticklabels([f'{ticks[-1]:.2f}'])
colorbar_combined.set_ticks(ticks)
colorbar_combined.set_ticks([ticks[-1]])

# sc_combined.set_clim(new_lower_limit_9_11,0.14)
# ax_3d_1.set_xlim(-8, 6)
# ax_3d_1.set_ylim(0, 7.5)
# ax_3d_1.set_zlim(-5, 1)
# ax_3d_2.set_xlim(-8, 6)
# ax_3d_2.set_ylim(0, 7.5)
# ax_3d_2.set_zlim(-5, 1)

ax_3d_1.set_xlim(-4.5, 8)
ax_3d_1.set_ylim(-4, 7.5)
ax_3d_1.set_zlim(-5, 4)
ax_3d_2.set_xlim(-4.5, 8)
ax_3d_2.set_ylim(-4, 7.5)
ax_3d_2.set_zlim(-5, 4)


# Ensure layout is consistent
plt.tight_layout()
plt.show()

#%%
from scipy.spatial.distance import pdist
points_c1 = np.vstack((x_axis1, y_axis1, z_axis1)).T
pairwise_distances = pdist(points_c1)  # Compute pairwise distances
mean_pairwise_distance = np.mean(pairwise_distances)
print("Mean Pairwise Distance C1 (Heterogeneity):", mean_pairwise_distance)

points=np.vstack((x_axis2,y_axis2,z_axis2)).T
pairwise_distances = pdist(points)  # Compute pairwise distances
mean_pairwise_distance = np.mean(pairwise_distances)
print("Mean Pairwise Distance C2 (Heterogeneity):", mean_pairwise_distance)

points=np.vstack((x_axis3, y_axis3, z_axis3)).T
pairwise_distances = pdist(points)  # Compute pairwise distances
mean_pairwise_distance = np.mean(pairwise_distances)
print("Mean Pairwise Distance C3 (Heterogeneity):", mean_pairwise_distance)

points=np.vstack((x_combined, y_combined,z_combined))
pairwise_distances = pdist(points)  # Compute pairwise distances
mean_pairwise_distance = np.mean(pairwise_distances)
print("Mean Pairwise Distance All (Heterogeneity):", mean_pairwise_distance)

