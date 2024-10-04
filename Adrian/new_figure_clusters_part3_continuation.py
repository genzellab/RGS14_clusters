#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct  3 00:35:24 2024

@author: adrian
"""
cmaps = ['inferno'] #, 'plasma', 'inferno',plasma cividis

# Plot clusters on the third subplot (ax3)
sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, cmaps[0], ax3)  # Cluster 3
sc2 = plot_cluster_noKDE(x_axis2, y_axis2, z_axis2, ax3)  # Cluster 4

# Customize ax3 plot
ax3.set_title('3D Kernel Density Estimation',fontsize=12)  # Title for ax3
ax3.set_xlabel('PCA1', fontsize=10)
ax3.set_ylabel('PCA2', fontsize=10)
ax3.set_zlabel('PCA3', fontsize=10)

# Set axis limits for ax3
ax3.set_xlim(-10, 35)
ax3.set_ylim(-10, 10)
ax3.set_zlim(-7.770710858935466, 20)

# Add colorbar for the first cluster in ax3
fig.colorbar(sc1, ax=ax3, label='KDE All ripples')  # Add colorbar for sc1
fig.colorbar(sc1, ax=ax3, label='KDE All ripples')  # Add colorbar for sc1
fig.colorbar(sc1, ax=ax3, label='KDE All ripples')  # Add colorbar for sc1

# Set view angle for ax3
ax3.view_init(azim=180, elev=20)

# Optional: Set ticks and grid
ax3.tick_params(axis='x', labelsize=10)  # X-axis tick font size
ax3.tick_params(axis='y', labelsize=10)  # Y-axis tick font size
ax3.tick_params(axis='z', labelsize=10)  # Z-axis tick font size
ax3.grid(True)  # Enable grid for ax3


# Plot clusters on the fourth subplot (ax4)
sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, cmaps[0], ax4)  # Cluster 3
sc2 = plot_cluster_noKDE(x_axis2, y_axis2, z_axis2, ax4)  # Cluster 4

# Customize ax4 plot
ax4.set_title('3D Kernel Density Estimation (No Grid)',fontsize=12)  # Title for ax4
ax4.set_xlabel('PCA1', fontsize=10)
ax4.set_ylabel('PCA2', fontsize=10)
ax4.set_zlabel('PCA3', fontsize=10)

# Set axis limits for ax4
ax4.set_xlim(-10, 35)
ax4.set_ylim(-10, 10)
ax4.set_zlim(-7.770710858935466, 20)

# Add colorbar for the first cluster in ax4
fig.colorbar(sc1, ax=ax4, label='KDE All ripples')  # Add colorbar for sc1
fig.colorbar(sc1, ax=ax4, label='KDE All ripples')  # Add colorbar for sc1
fig.colorbar(sc1, ax=ax4, label='KDE All ripples')  # Add colorbar for sc1

# Set view angle for ax4
ax4.view_init(azim=180, elev=20)

# Optional: Set ticks and grid
ax4.tick_params(axis='x', labelsize=10)  # X-axis tick font size
ax4.tick_params(axis='y', labelsize=10)  # Y-axis tick font size
ax4.tick_params(axis='z', labelsize=10)  # Z-axis tick font size
ax4.grid(False)  # Enable grid for ax4

ax3.set_xticks([-10, 0, 10, 20, 30])  # For the X-axis
ax3.set_yticks([-10, -5, 0, 5, 10])   # For the Y-axis
ax3.set_zticks([0, 10, 20])           # For the Z-axis

ax4.set_xticks([-10, 0, 10, 20, 30])  # For the X-axis
ax4.set_yticks([-10, -5, 0, 5, 10])   # For the Y-axis
ax4.set_zticks([0, 10, 20])           # For the Z-axis
#%%
plt.savefig("plot16.pdf", format='pdf', dpi=100, bbox_inches='tight')


#%%

ax.set_xlabel("PCA1", fontsize=12)
ax.set_ylabel("PCA2", fontsize=12)
ax.set_zlabel("PCA3", fontsize=12)

ax.tick_params(axis='x', labelsize=12)  # X-axis tick font size
ax.tick_params(axis='y', labelsize=12)  # Y-axis tick font size
ax.tick_params(axis='z', labelsize=12)  # Y-axis tick font 


ax2.set_xlabel("PCA1", fontsize=12)
ax2.set_ylabel("PCA2", fontsize=12)
ax2.set_zlabel("PCA3", fontsize=12)

ax2.tick_params(axis='x', labelsize=12)  # X-axis tick font size
ax2.tick_params(axis='y', labelsize=12)  # Y-axis tick font size
ax2.tick_params(axis='z', labelsize=12)  # Y-axis tick font 


ax3.set_xlabel("PCA1", fontsize=12)
ax3.set_ylabel("PCA2", fontsize=12)
ax3.set_zlabel("PCA3", fontsize=12)

ax3.tick_params(axis='x', labelsize=12)  # X-axis tick font size
ax3.tick_params(axis='y', labelsize=12)  # Y-axis tick font size
ax3.tick_params(axis='z', labelsize=12)  # Y-axis tick font 

ax4.set_xlabel("PCA1", fontsize=12)
ax4.set_ylabel("PCA2", fontsize=12)
ax4.set_zlabel("PCA3", fontsize=12)

ax4.tick_params(axis='x', labelsize=12)  # X-axis tick font size
ax4.tick_params(axis='y', labelsize=12)  # Y-axis tick font size
ax4.tick_params(axis='z', labelsize=12)  # Y-axis tick font 

# Set custom title for the third subplot (ax3)
ax3.set_title('3D Kernel Density Estimation', fontsize=10)  # Example title for ax3

# Set custom title for the fourth subplot (ax4)
ax4.set_title('3D Kernel Density Estimation', fontsize=10)  # Example title for ax4


